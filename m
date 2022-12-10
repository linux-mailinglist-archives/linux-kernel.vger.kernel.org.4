Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4B6649033
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 19:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiLJSiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 13:38:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiLJSiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 13:38:01 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BEB7F01A
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 10:38:00 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id c13so5919753pfp.5
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 10:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FbOFRSFNWc0TQHFBoZfUW3DKjgTHvU2458m2mJ2hLTA=;
        b=Qke1071KChkc42+nucj0OH/1nqcHsCprxGYxniIdB40lT5dgim2kSxJGpL6ilcbMix
         oX2V7FlUtQns7jrBvMyL1UDS883SZNumo9YawBOhFbu1PkFwjmGs4qRiBkHVb5/CBXm5
         mPIuWVpNOf6og6hmdIfJtPFvcY7l7kXacg7itvLyPaftYL5VaknQh3Qap8WZsqzIRP+1
         HwjaIgK7FX2xq7hOHE8bssnjbP2judi4C2f+MzbL062QRttcFTdDxd2oSr+l499Kq3Ag
         SeuHDLpTIrltIk+AYondUXJyx4+QOLxxE3QuuB2TF9jozIIs2ubHwEuYh4fRwuuOedzx
         RVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FbOFRSFNWc0TQHFBoZfUW3DKjgTHvU2458m2mJ2hLTA=;
        b=duKdbhwKAtZhkf9cRCJioudJVCgBD/DBveC4ANPgYAhQunI48F6fvZ5m6uD7BGPx1V
         m3XwIWy8TxDXv5Kii+bbFNImp8O2lhftk0cX1WVsphsQJqWZRJcj/BtmJuOjRElp0IfA
         y9emF146ZwvUS1SuN+98wgZw/6z51XebPrWJ7PjFWKogmGdlqvRJeTiFiHqmlOSwnw/s
         QLqsxNLLCclR6KnU0uXYM6OPBilKKE8O0oD4HJqafTQ/4Gq3AA2rH93wAQl+xO/PKbh0
         BYh9QoAqMD6lubhi4Pk1xFnmEWVYEsaE8oDHqDJO6ka/FGD9ySHmiaoMKpQtf4amy0oG
         V4yA==
X-Gm-Message-State: ANoB5pmcidRM8jCaH2T4DOoOlZ48krMr1LLVuYyRU+6Va1bEiZJllbzo
        Q2qER+/RWMpQr0MOb+u+Xg0=
X-Google-Smtp-Source: AA0mqf6KRSFjnyi2eDTn/II+25rMsvZBzigpptR+ba0YKEEhaBxaOsyK5d6i3XqiCoYzxKzmzCsgdA==
X-Received: by 2002:a05:6a00:1411:b0:574:a541:574a with SMTP id l17-20020a056a00141100b00574a541574amr12136513pfu.0.1670697479535;
        Sat, 10 Dec 2022 10:37:59 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id x28-20020aa78f1c000000b0056bc5ad4862sm3055146pfr.28.2022.12.10.10.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 10:37:59 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sat, 10 Dec 2022 08:37:57 -1000
From:   Tejun Heo <tj@kernel.org>
To:     "lilingfeng (A)" <lilingfeng3@huawei.com>
Cc:     linux-kernel@vger.kernel.org, jack@suse.cz, bingjingc@synology.com,
        ebiggers@google.com, james.smart@broadcom.com, houtao1@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH-next] lib: parser: optimize match_NUMER apis to use local
 array
Message-ID: <Y5TSBUxQPhvngK7J@slm.duckdns.org>
References: <20221209063434.1566682-1-lilingfeng3@huawei.com>
 <Y5No5kMNGGJkmcPn@slm.duckdns.org>
 <8ed91647-f429-493e-b4e1-1f6bf11c228b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8ed91647-f429-493e-b4e1-1f6bf11c228b@huawei.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sat, Dec 10, 2022 at 10:51:11AM +0800, lilingfeng (A) wrote:
> Thank you for your advice. But I think match_number() is aimed to turn the
> string to num, so maybe it's better to return an error code rather than
> using match_stlcpy() to truncate it to give a wrong num when the string
> is too long to store.

Yeah, so, you check the the returned length and return an error code if the
returned value is too long for the buffer. That's how this family of
functions get error-checked.

> > > +{
> > > +	size_t len = s->to - s->from;
> > > +
> > > +	if (!s->from)
> > > +		return -EINVAL;
> > If we use match_strlcpy() we lose the above null check but given that other
> > match_*() functions aren't doing it, this likely shouldn't matter.
> 
> Like this:
> match_strdup
>  kmemdup_nul
>   if (!s) // null check has been done here
>    return NULL
> So I think null check may be necessary.

I mean, it's there now but other match functions don't, so it's unlikely
that the NULL check is necessary unless we're saying "parsing this type
string can encounter NULL inputs but these don't". That said, it doesn't
really matter. If you wanna keep the NULL check, do so before calling
strlcpy.

Thanks.

-- 
tejun
