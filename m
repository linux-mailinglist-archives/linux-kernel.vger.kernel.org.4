Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA9A6B6075
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 21:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjCKUTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 15:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCKUTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 15:19:23 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4489B2A155;
        Sat, 11 Mar 2023 12:19:22 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id bi9so10960632lfb.2;
        Sat, 11 Mar 2023 12:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678565960;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uAh7UYyS4J9vkKx/jH0XKuV34LhyWxZES+T2osD7hNQ=;
        b=cqQjIzO+iO6NavgeaUHtf1zFGuowXq66QBnY5qggNrwOeRalYx446q4i/mYo151Ozv
         HQNe2y08cbq6nCL3zJlocDjeX6VIwbNV0T5uJXu4dA2Mce5hFpYXyJ4OAiGzoikMSSAn
         gSlhwmyu3u83rwSGw/25Cp4r2O5x2quLQpeiOS/ZfETvbSFvPDN4Q3tWumcEVVko989B
         EnlP3K4jtsz3RRy1q4OIE/DOZTYu7vK2SCbzPDyA1eDdzcMlNoAg3lrWlWl2Nkj6pccW
         AKIn5qvLJuna6m5UMXpogklRgaXF7okd9/0CwzpoOXiNCKVlfm9yKSEiXTwSzac5d2++
         6c0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678565960;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uAh7UYyS4J9vkKx/jH0XKuV34LhyWxZES+T2osD7hNQ=;
        b=CotzbFH9rCzudo0CCfkMpKchAGEdKkdfsfZ5O2ZWBz3tt1FZqY2tmEJXy4kMOk6/O5
         NF6A/5GnLn2JuG9dpjys296dYCBgTMM7bS8EieWhRbifWMckgg/honj31ukP3wd09uQ2
         fhXK5RPP6baIGLsJlwUxxj/rupvEzR+wzRSbvHe56Dp2CL4S6zuOl55Q59OMfQMaSe+V
         X+Us50P7OHnTHFUzCoUiy6JRchWBCz04OKMus/6x5MwqIYPoXEW+xnEOxVaZr32OgCZ2
         aRzQ9tOS+LtCz9CD8JSTiukVxN6Z40Tq156FtTfqfmIpDFcnDEBwyCqpmOpuRTKHy8zh
         AZJw==
X-Gm-Message-State: AO0yUKXDmt6oV7a9iurJ4DcHuzjX0JurXljdDmEerZtXgvizkghq1QIL
        VdPsTh8w5HMnFLgh3HCdVGpnF+xbzI0=
X-Google-Smtp-Source: AK7set+uklYTNxXUbNN62o0JdFcDGyPcIBcaE+KVD4k754JpPhgz+jMKS1iOYb1PfJSx5xTb8xNUNQ==
X-Received: by 2002:a05:6512:694:b0:4d8:86c1:477f with SMTP id t20-20020a056512069400b004d886c1477fmr1759408lfe.20.1678565960121;
        Sat, 11 Mar 2023 12:19:20 -0800 (PST)
Received: from [192.168.1.103] ([31.173.84.174])
        by smtp.gmail.com with ESMTPSA id c6-20020ac25306000000b004a2c447598fsm410175lfh.159.2023.03.11.12.19.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Mar 2023 12:19:19 -0800 (PST)
Subject: Re: [PATCH] pata_parport: fix possible memory leak
To:     Ondrej Zary <linux@zary.sk>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Dan Carpenter <error27@gmail.com>, Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <3ab89ddc-cb60-47c4-86ad-cdad94a8a3d7@kili.mountain>
 <20230311185149.22957-1-linux@zary.sk>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <e02f5626-81be-d949-d2b4-7f70820b409c@gmail.com>
Date:   Sat, 11 Mar 2023 23:19:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20230311185149.22957-1-linux@zary.sk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/23 9:51 PM, Ondrej Zary wrote:

> When ida_alloc() fails, "pi" is not freed although the misleading
> comment says otherwise.
> Move the ida_alloc() call up so we really don't have to free it.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Link: https://lore.kernel.org/r/202303111822.IHNchbkp-lkp@intel.com/
> Signed-off-by: Ondrej Zary <linux@zary.sk>

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>

[...]

MBR, Sergey
