Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D50B648718
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 17:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiLIQ5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 11:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiLIQ5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 11:57:14 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EB4944D4
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 08:57:13 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id hd14-20020a17090b458e00b0021909875bccso8432711pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 08:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uNvvdxQwbO3jIj6Fg1xjmn4oL9jbZQfyPZoUc3RJBGU=;
        b=KsOUbuwBjenmhrBjEfJ7A4HZlKJZw5MZFSlVqjf6xE+HCgdnPbxQgl8mTgk8SLO2gS
         QVUq/5XOhi7XpCwfnqqOuPD24zb5clK9Sy8FaXvuNrfQZ/vBuIbrohv/Y84SDUcrSKz/
         RNAWnK4+9i/TWmPUaZWo842VI+GuwPHuV8sMwlurSgumz1TgQWeThhCh6Nm5IvqKS0O3
         v7rvZZ3EUiOC/rxWcNgS9XWVy2407p0vYSF3+Dt+ouW/snWnTbi0mWHKvSadQDiJIrvD
         hJQYrCE1yzlhk8cPF9XLemsn6/EZTSgnHcIn6NY5bt47Dl/54RmPij5i++nnZuwJyxRR
         5R4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uNvvdxQwbO3jIj6Fg1xjmn4oL9jbZQfyPZoUc3RJBGU=;
        b=ChpOlkniaqwDAsTwW4gwia7WhTc2Fpq4Hgm/bRbFrJA8vfZ/b1OAOjQHsEPVCMomPC
         /lhyqbcj9g0jRHEzWdixzxrxSpn4l61DJ1QzKMUBi2FMvZEdR28dox5EWCIc9ZimdSjz
         IHZ9fEaOrcxr4YMubBKgELP7cJRf+XGw1uhCiuWPUZ7JqiP/x5TO9wQussyEhWdwB69m
         ZbFb6deWdMjtkOrMKys1H/SdncELno9fOOz/sk8x+ySKnzi9xHrOok1HKAYNnXr71h53
         jo+kkZSd1hbGaNgXUPyC22Dq5WmoYScPed5S2EHoXrqEBkwjEoswq1vdXP6sS3s5EWbg
         pjWg==
X-Gm-Message-State: ANoB5pmax+vAg4wiiL0mUqVYev/ghFIRysdddWdcOmthE9k+2ej7+wPH
        UUVnWMgGYXc8N/ycJRDpWlM=
X-Google-Smtp-Source: AA0mqf6KRXeEQvuo+ItW5Qm9zsllcUNoz0xVPtJP7GlFHzM5Zuj+dfouMJY2mjPAVl9vK12plUTRew==
X-Received: by 2002:a17:902:9044:b0:186:daeb:bc0a with SMTP id w4-20020a170902904400b00186daebbc0amr6187873plz.67.1670605032789;
        Fri, 09 Dec 2022 08:57:12 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:83dd])
        by smtp.gmail.com with ESMTPSA id ju2-20020a170903428200b00186ae20e8dcsm1541270plb.271.2022.12.09.08.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 08:57:12 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 9 Dec 2022 06:57:10 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Li Lingfeng <lilingfeng3@huawei.com>
Cc:     linux-kernel@vger.kernel.org, jack@suse.cz, bingjingc@synology.com,
        ebiggers@google.com, james.smart@broadcom.com, houtao1@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH-next] lib: parser: optimize match_NUMER apis to use local
 array
Message-ID: <Y5No5kMNGGJkmcPn@slm.duckdns.org>
References: <20221209063434.1566682-1-lilingfeng3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209063434.1566682-1-lilingfeng3@huawei.com>
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

In general, I think this is a great idea. Some nits below:

On Fri, Dec 09, 2022 at 02:34:34PM +0800, Li Lingfeng wrote:
> +/*
> + * max size needed by diffrent bases to express U64
> + * HEX: "0xFFFFFFFFFFFFFFFF" --> 18
> + * DEC: "18446744073709551615" --> 20
> + * OCT: "01777777777777777777777" --> 23
> + * pick the max one to define U64_MAX_SIZE
> + */
> +#define U64_MAX_SIZE 23

Bikeshedding but how about naming it like NUMBER_BUF_LEN and including the
space for '\0'? Or just give it some extra space and make it 32 bytes.

> +static int match_strdup_local(const substring_t *s, char *buf)

I find it weird to name this as generic as match_strdup_local() and make it
assume that the buffer length is U64_MAX_SIZE + 1. Maybe just let the caller
pass in the buffer length as a parameter? Then, it's just strcpy and there
already is match_strlcpy() so we don't need this at all.

> +{
> +	size_t len = s->to - s->from;
> +
> +	if (!s->from)
> +		return -EINVAL;

If we use match_strlcpy() we lose the above null check but given that other
match_*() functions aren't doing it, this likely shouldn't matter.

Thanks.

-- 
tejun
