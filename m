Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E0C6D183A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 09:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjCaHNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 03:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjCaHNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 03:13:00 -0400
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4E6728A;
        Fri, 31 Mar 2023 00:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
        s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2wX7kk84wGIs9+erUIwfdfDQ+Jpj8eePWOZPFDFpn54=; b=q6kCfk6/fpolQcMBg4CRgFixF2
        rtpoo3Xyhb1dcl40Y9oF2ooSPeVX3H6VOYU1fnlipDUVW4eQaeMPQ1pKEweCZea4JGyP+/0jnruBP
        PUeehIOM+ccFrDGotYB0DghGB69sXNt8UFUmx4MND8xdWQNZYsBOel+2eFgihfD8NOLf6gOiVKM/s
        Qg7JLvYubi1LkhHjjO0w/ZQN32kTZCyebfD+MEgxFva4Pgd2bwwFAstPkI6SrhBJBo1ywf0GobkX6
        MLjVWBX88Q/47E5KqBVsqxUvnoCImRGKl1vvTcs6Zpw3nR2f5oAm8HeRt63unfq/6unYe4vTIGRe8
        yQtmcZWQ==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70] helo=[192.168.1.10])
        by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <cyndis@kapsi.fi>)
        id 1pi8wC-004OBK-NS; Fri, 31 Mar 2023 10:12:40 +0300
Message-ID: <e1c0721e-7a73-aee6-9fe2-9cab8f353a49@kapsi.fi>
Date:   Fri, 31 Mar 2023 10:12:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] thermal: tegra-bpmp: Handle offline zones
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Mikko Perttunen <mperttunen@nvidia.com>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230330094904.2589428-1-cyndis@kapsi.fi>
 <f0d51904-d363-cb76-cd6f-f1ebefd0aa5a@linaro.org>
From:   Mikko Perttunen <cyndis@kapsi.fi>
In-Reply-To: <f0d51904-d363-cb76-cd6f-f1ebefd0aa5a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 91.158.25.70
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/31/23 00:14, Daniel Lezcano wrote:
> On 30/03/2023 11:49, Mikko Perttunen wrote:
>> From: Mikko Perttunen <mperttunen@nvidia.com>
>>
>> Thermal zones located in power domains may not be accessible when
>> the domain is powergated. In this situation, reading the temperature
>> will return -BPMP_EFAULT. When evaluating trips, BPMP will internally
>> use -256C as the temperature for offline zones.
>>
>> For smooth operation, for offline zones, return -EAGAIN when reading
>> the temperature and allow registration of zones even if they are
>> offline during probe.
>>
>> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> 
> Applied, thanks
> 

Thank you!
Mikko
