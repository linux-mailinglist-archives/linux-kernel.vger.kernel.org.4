Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566EC6297A0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 12:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiKOLj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 06:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbiKOLjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 06:39:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16ECD7656
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 03:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668512299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cBuz4dB8pKEl0Eik12rqRP7QJDFUdnfWL8rmGUmRMkk=;
        b=KOSvYmpGYqToOyrXpZD8jSyW+ZzwuoT/BTOgHJi9BrSWlsTV2cE0XH0daUW5Ar02YVpCqi
        RHZvHFtvQbvz2MuQK0PQGKo36KS70WXRVt+g239oTnuql/6j7pTWwkBU9g/+sN1piOPvNY
        FI228Cm08jfBH/8k5/HIZuYHK19tiAo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-635-1eG0Y-rqPMiIrXLxB8EwDw-1; Tue, 15 Nov 2022 06:38:18 -0500
X-MC-Unique: 1eG0Y-rqPMiIrXLxB8EwDw-1
Received: by mail-ed1-f72.google.com with SMTP id s15-20020a056402520f00b0046321fff42dso9723481edd.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 03:38:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cBuz4dB8pKEl0Eik12rqRP7QJDFUdnfWL8rmGUmRMkk=;
        b=x1z7fk0RutrQe1FStHomUiYYcwztS3/gliJdClZl/7KSL/uhO3MZwWEBaRCoc+h7s1
         +80+JJUSs4AoVb+S7X98EaJ9iMKntdw4/NyJAlw1asnfwe04gr3AEhKj/xXwg9AyD82X
         c8a97uOJo3PYyjNXBgPREhLOx34bDQbufxVY/5SRUG2PdwHP1vpCmFu5a3E41fUiNxWF
         eLzyZNiz5rVq2/kJRbNfQ/QYumKBt4QbHj9S+JQ3ktyuzpIs5zjIQMP/ggkm/DqqzYd1
         7EVErV1YFEVEZyF+jBR7hS9AQ0f7FDUmQGnpbJGBkAVwICoR4mMm4bhFAJdGlOMD4CQL
         WwIw==
X-Gm-Message-State: ANoB5pmeOglsOR2eKTn9zzvrdasnAIIf1mjZ4a+9T4iidbfy6oq3TelD
        1WmkLKGlc1+tp5ouwEuvzKxrP9hOEJeav6GQpQXbzY5LFqIalisQSWAewdYA31SaDJrjxZugqwj
        OD/DqSvuwOBhQ3iD7LkKNYvBW
X-Received: by 2002:a17:906:81da:b0:78d:a01b:b474 with SMTP id e26-20020a17090681da00b0078da01bb474mr13759811ejx.8.1668512297138;
        Tue, 15 Nov 2022 03:38:17 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4wT12I4HXRTPwOUfdpoipCB1G2eQz/MycoS5CRqzbh4CrriFYMveBAuh7Af5AA11wxq9NXlA==
X-Received: by 2002:a17:906:81da:b0:78d:a01b:b474 with SMTP id e26-20020a17090681da00b0078da01bb474mr13759801ejx.8.1668512296987;
        Tue, 15 Nov 2022 03:38:16 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id z4-20020a1709063ac400b007acd04fcedcsm5404574ejd.46.2022.11.15.03.38.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 03:38:16 -0800 (PST)
Message-ID: <14f8fbd3-b1db-34af-d443-947bbdb21e37@redhat.com>
Date:   Tue, 15 Nov 2022 12:38:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 1/1] platform/x86/amd: Fix pmc compile dependency errors.
Content-Language: en-US, nl
To:     Borislav Petkov <bp@alien8.de>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     Yupeng Li <liyupeng@zbhlos.com>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "caizp2008@163.com" <caizp2008@163.com>,
        "smf-linux@virginmedia.com" <smf-linux@virginmedia.com>
References: <20221026072531.346013-1-liyupeng@zbhlos.com>
 <0910bcc4-d55f-6f3a-b2df-4e30d164aeeb@redhat.com>
 <721f6a1a-1144-4fe4-e722-2ba2d7200680@amd.com> <Y25m8tPTtyfHOCfK@zn.tnic>
 <MN0PR12MB6101AB9F2AD8A41CE3EC5650E2009@MN0PR12MB6101.namprd12.prod.outlook.com>
 <Y25sohHGkdAn5OZD@zn.tnic>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <Y25sohHGkdAn5OZD@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/11/22 16:39, Borislav Petkov wrote:
> On Fri, Nov 11, 2022 at 03:16:10PM +0000, Limonciello, Mario wrote:
>> I sent up a patch for it, but Hans hasn't applied it.
>> https://patchwork.kernel.org/project/platform-driver-x86/patch/20221108023323.19304-1-mario.limonciello@amd.com/
> 
> Yap, that fixes it.
> 
> So yeah, Hans, make sure to Cc: stable too when applying.

Done. I'll send this out in my next fixes pull-req to Linus
before the end of this week.

Regards,

Hans


