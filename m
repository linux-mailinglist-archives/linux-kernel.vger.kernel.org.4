Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13F061FC81
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 19:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbiKGSC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 13:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbiKGSCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 13:02:07 -0500
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DBB275C4;
        Mon,  7 Nov 2022 09:58:18 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id ABDF780079;
        Mon,  7 Nov 2022 18:58:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1667843896;
        bh=nYfREh02uFhu5a7Npuc623PJyBQ84xQUEQ1muUCGdKU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=H9DqZmp6CSBkQyQgUWXIxosZzK6ub89tzQJaQ0h+cBcOKLwxa1qyXcitJmVTb7w4/
         /nE3plO1c+KqA7vMuSYgU2+nH+ThSd1PfqRoN4+Rg0ASOHFKD7d838ruTduAtT35Pc
         d6nBdWDTE8LkhRE/KFtHbOXLEeyDL/6JiWLSS0AnBEBZTwXsSNXv0OGtWKLBhcWdF4
         4TqfOpCgGDXjoTxnr/dYiq26nnSh4GMnHrySIFLWJQqfNMvIVfEfWPFn7hBst3KjcX
         C3yHM6+/NLLCpqkIJThHWl3Ai97Y/8AC4QBvz5ICgunNibnQd+XavIQEySH6fgF0+5
         IBp8n0tfrZFOw==
Message-ID: <50130fa2-e15a-a043-94c8-002ac0817135@denx.de>
Date:   Mon, 7 Nov 2022 18:58:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2] extcon: usbc-tusb320: Call the Type-C IRQ handler only
 if a port is registered
Content-Language: en-US
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        =?UTF-8?Q?Alvin_=c5=a0ipraga?= <alsi@bang-olufsen.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yassine Oudjana <y.oudjana@protonmail.com>
References: <20221107153317.657803-1-y.oudjana@protonmail.com>
 <Y2kyJqfhB4DXt7Te@kuha.fi.intel.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <Y2kyJqfhB4DXt7Te@kuha.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/22 17:28, Heikki Krogerus wrote:
> On Mon, Nov 07, 2022 at 06:33:17PM +0300, Yassine Oudjana wrote:
>> From: Yassine Oudjana <y.oudjana@protonmail.com>
>>
>> Commit bf7571c00dca ("extcon: usbc-tusb320: Add USB TYPE-C support")
>> added an optional Type-C interface to the driver but missed to check
>> if it is in use when calling the IRQ handler. This causes an oops on
>> devices currently using the old extcon interface. Check if a Type-C
>> port is registered before calling the Type-C IRQ handler.
>>
>> Fixes: bf7571c00dca ("extcon: usbc-tusb320: Add USB TYPE-C support")
>> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
>> Reviewed-by: Marek Vasut <marex@denx.de>
> 
> Looks good to me. FWIW:
> 
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Likewise, looks good. You already have my RB. Thanks !
