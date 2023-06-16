Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70AF573273B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 08:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243228AbjFPGUF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 16 Jun 2023 02:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243365AbjFPGT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 02:19:56 -0400
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCF8269D;
        Thu, 15 Jun 2023 23:19:55 -0700 (PDT)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1b50e309602so3267675ad.0;
        Thu, 15 Jun 2023 23:19:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686896394; x=1689488394;
        h=content-transfer-encoding:fcc:content-language:user-agent
         :mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o/pa9zy1PtKHGNvngP6qHVNDaGkPbLnoGxIcEw3KeKA=;
        b=Z2Bug4JWMXvF64S7RfrmEdjxXc5PZ0sUkoGVF+WEH0+gf4S+M7U3QNBodcJkHNZu/C
         bgF+6Y3IU9thurUxPeOafqvTK22jTCT86MHP9Fi18jD0rulRIUGLy4KFOqdUKgZkF7MJ
         JJ6UaQIrl7HyLgBZMB28y1IK+qgu4h+h0120+r53OvNnRM9gasllgV0osb/hysMOJ4pS
         fS78ulpsOTej137BGd9tS651cir9HkVoeKZC55CE/V287ZodcM3IEaqF8LVdyBmCZWRR
         0TdufDeIhjPMO7FtPmyXb+4eZ1Wvq47wJm2paLySeXJKMfSl5aPg87iIXN+YPDSj3LPl
         EELg==
X-Gm-Message-State: AC+VfDxx6av/4MH+5XHWW21adQiQw4KTobn3rCW2ErSWWLGvA0gGLWhG
        JLluBIQq29mn6Uhavaftz34=
X-Google-Smtp-Source: ACHHUZ6wr9ey9/YwC8SQsIxnhTKv+OU8p5VbqgUn+kt7WC8pvZ5LGXWOmxB5kAy5cZs1l4GQ2Voh9A==
X-Received: by 2002:a17:902:ead2:b0:1b0:5304:5b48 with SMTP id p18-20020a170902ead200b001b053045b48mr1089927pld.0.1686896394472;
        Thu, 15 Jun 2023 23:19:54 -0700 (PDT)
Received: from localhost ([2408:8453:744:15bc:1d2e:7d4e:2024:8394])
        by smtp.gmail.com with ESMTPSA id t13-20020a1709027fcd00b001b3df3ae3f8sm349306plb.281.2023.06.15.23.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 23:19:54 -0700 (PDT)
From:   Hongyu Xie <xiehongyu1@kylinos.cn>
To:     linux@armlinux.org.uk, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, corbet@lwn.net
Cc:     rdunlap@infradead.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, xy521521@gmail.com,
        oe-kbuild-all@lists.linux.dev, lkp@intel.com, bagasdotme@gmail.com,
        Hongyu Xie <xiehongyu1@kylinos.cn>
Subject: Re: [RESEND PATCH v4 -next] tty: serial: add panic serial helper
Date:   Fri, 16 Jun 2023 14:19:50 +0800
Message-Id: <32e022c7-f041-3bf2-2f68-3ed2119c951d@kylinos.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2023061606-hunk-overdraft-8d04@gregkh>
References: <20230614025512.27746-1-xiehongyu1@kylinos.cn> <2023061502-submerge-preachy-4413@gregkh> <fbfbbad5-2418-5c1a-87f1-dc2ca20204aa@kylinos.cn> <2023061606-hunk-overdraft-8d04@gregkh>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101 Thunderbird/102.11.0
Content-Language: en-US
X-Mozilla-Draft-Info: internal/draft; vcard=0; receipt=0; DSN=0; uuencode=0; attachmentreminder=0; deliveryformat=1
X-Identity-Key: id1
Fcc:    imap://xiehongyu1%40kylinos.cn@imap.kylinos.cn/Sent
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2023/6/16 14:03, Greg KH 写道:
> On Fri, Jun 16, 2023 at 10:31:15AM +0800, Hongyu Xie wrote:
>> 在 2023/6/15 18:17, Greg KH 写道:
>>> On Wed, Jun 14, 2023 at 10:55:12AM +0800, Hongyu Xie wrote:
>>>> It was inspired by kgdboc.
>>>>
>>>> This is a debug module that allows you to get all kernel logs
>>>> after panic.
>>>>
>>>> Normally you need to attach a USB-to-UART tool or enable kdump
>>>> before panic happens to get log from kernel after panic. If you
>>>> didn't do that and kdump is not working, you can't get any log to
>>>> know what happened before panic. If you have a USB-to-UART tool
>>>> and the UART port on your computer is working. This module helps
>>>> you to get all kernel log after panic() is called.
>>>>
>>>> To use this, see Documentation/dev-tools/panic_serial_helper.rst.
>>>>
>>>> Tested on an arm64 device.
>>>>
>>>> Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>
>>>> ---
>>>
>>> Why  is this a RESEND?  What's wrong with the previous version?
>> Nobody review v4 for over a week.
> 
> That's fine, but you need to say _why_ this is being resent, otherwise
> we have no idea, and this just moves to the bottom of our review queue.
"Nobody review v4 for over a week." was the reason. I should resubmit 
the same patch or ping instead of using "RESEND", is that what you mean?

> 
> thanks,
> 
> greg k-h
thanks,

Hongyu Xie
