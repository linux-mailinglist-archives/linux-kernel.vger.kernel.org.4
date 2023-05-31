Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12D0718A33
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 21:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjEaTcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 15:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjEaTch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 15:32:37 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5732E126;
        Wed, 31 May 2023 12:32:36 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b04782fe07so239325ad.3;
        Wed, 31 May 2023 12:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685561555; x=1688153555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5J4LPQ9ReuK0IhpZ5ik66n+nr9CBcPra6BZYguF+U8w=;
        b=bZZ7Cqu92UozlVfYY/7HeI8nBwOZ0nJum2vd8QNMweoxKz6CuQF640GNfK/WjgME85
         weMvgXX41I/JJFiQTIt/nbxts4Fugcp/xoU5fxrCpJ5ONRNY+QG1Mfqur7Q/87Bb1l6p
         mwkcL2mvCBHu3kkg4loIdrBaj36y8eTJi9NSe1f+GTBCoAvI98wqz8p9geHQ7VKV19+x
         ORhX8B/qilw5nzUtYYkVKCzq4CYN6EGmqaflwTzegSUOHf0RnE85Rjrr3isAEUUG3TZ8
         zmAniNIZIOsMEz9i3XfQfryBnNlhYUHIQUMe9m/MgNJk2wvrx4e+Z+oQfCpEfuv7vkIH
         jNfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685561555; x=1688153555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5J4LPQ9ReuK0IhpZ5ik66n+nr9CBcPra6BZYguF+U8w=;
        b=g0l78voiU+7SfpV/3KFAP+SHkJ+wno4VT24cU//XD9VbDllSeJU+zrhaK63Pnw11XI
         OL8u8zsDD0mT/Wk2eeZBkDn4TtOE2ZkaBem7f6hVaB2zDxG2ftnvr9liWCyDAReH/pve
         KJ0NsZm3ZhIUccc1FyAYwF5rvE9xkQelDJTANz0tHUdgNCWWqBrnsYeQIcrGBOXB6g+w
         1Viwwc67OjMNCj5S0utd3Hxl/cJFu1J/y0sZd7j621Ygvbm9mu03qyQrty5oq2kr4NVS
         ZdgIEjodvEyBDQpqT3JFzam4E5TSZqoesIPas5brXHwVt2TBeCxjsaLVT3iDFM2VIdbT
         s+4A==
X-Gm-Message-State: AC+VfDyGJnRGCG/s6HXISYR5A9gRCEYG073zJgO5xrW9LLHumG/sP0Ps
        euSLBNtahWdwPX3ajCKLNGA=
X-Google-Smtp-Source: ACHHUZ4JZAefqCNzsj8EGiZ8A5V8CXK9/MA9+qBWXlQYSqovGOm/CXCHabJkAsLEJ9mn4cKQRisToQ==
X-Received: by 2002:a17:902:da85:b0:1b0:35c7:feed with SMTP id j5-20020a170902da8500b001b035c7feedmr5792589plx.59.1685561555401;
        Wed, 31 May 2023 12:32:35 -0700 (PDT)
Received: from ubuntu777.domain.name (36-228-82-61.dynamic-ip.hinet.net. [36.228.82.61])
        by smtp.gmail.com with ESMTPSA id e6-20020a170902d38600b001a67759f9f8sm1778613pld.106.2023.05.31.12.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 12:32:34 -0700 (PDT)
From:   Min-Hua Chen <minhuadotchen@gmail.com>
To:     david.laight@aculab.com
Cc:     jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, minhuadotchen@gmail.com,
        paul@paul-moore.com, serge@hallyn.com
Subject: RE: [PATCH] capabilities: use logical OR
Date:   Thu,  1 Jun 2023 03:32:31 +0800
Message-Id: <20230531193231.58732-1-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <db536b16e33648fdb44629fc9c1c1afc@AcuMS.aculab.com>
References: <db536b16e33648fdb44629fc9c1c1afc@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Min-Hua Chen <minhuadotchen@gmail.com>
>> Sent: 29 May 2023 23:55
>> 
>> Use logical OR to fix the following sparse warnings:
>> 
>> security/commoncap.c:1358:41: sparse: warning: dubious: !x | y
>> 
>> No functional changes intended.
>
>Except it will run just that teeny, weeny bit slower.
>
>	David
>

Thanks for the comment.

I wrote a test case on my x86 machine to see the difference
between '|' and '||' versions.

The '|' version does 2 OR operations and 1 test. (all cases)
The '||' (logical or) version does 3 cmpl (worst case)
and 1 cmpl and 1 jump if the first argument is TRUE (best case).

For the readers, I think the logical OR version is clearer.


thanks,
Min-Hua

my test case:

void foo(void)
{
}

void bar(void)
{
}

int main(void)
{
	int a, b, c;
	if (a || b || c) 
		foo();
	else
		bar();
}

if (a || b || c) 
logical OR
Dump of assembler code for function main:
0x000000000000113f <+0>:     endbr64
0x0000000000001143 <+4>:     push   %rbp
0x0000000000001144 <+5>:     mov    %rsp,%rbp
0x0000000000001147 <+8>:     sub    $0x10,%rsp
0x000000000000114b <+12>:    cmpl   $0x0,-0xc(%rbp)
0x000000000000114f <+16>:    jne    0x115d <main+30>
0x0000000000001151 <+18>:    cmpl   $0x0,-0x8(%rbp)
0x0000000000001155 <+22>:    jne    0x115d <main+30>
0x0000000000001157 <+24>:    cmpl   $0x0,-0x4(%rbp)
0x000000000000115b <+28>:    je     0x1164 <main+37>
0x000000000000115d <+30>:    call   0x1129 <foo>
0x0000000000001162 <+35>:    jmp    0x1169 <main+42>
0x0000000000001164 <+37>:    call   0x1134 <bar>
0x0000000000001169 <+42>:    mov    $0x0,%eax
0x000000000000116e <+47>:    leave
0x000000000000116f <+48>:    ret
End of assembler dump.

if (a | b | c)
Dump of assembler code for function main:
0x000000000000113f <+0>:     endbr64
0x0000000000001143 <+4>:     push   %rbp
0x0000000000001144 <+5>:     mov    %rsp,%rbp
0x0000000000001147 <+8>:     sub    $0x10,%rsp
0x000000000000114b <+12>:    mov    -0xc(%rbp),%eax
0x000000000000114e <+15>:    or     -0x8(%rbp),%eax
0x0000000000001151 <+18>:    or     -0x4(%rbp),%eax
0x0000000000001154 <+21>:    test   %eax,%eax
0x0000000000001156 <+23>:    je     0x115f <main+32>
0x0000000000001158 <+25>:    call   0x1129 <foo>
0x000000000000115d <+30>:    jmp    0x1164 <main+37>
0x000000000000115f <+32>:    call   0x1134 <bar>
0x0000000000001164 <+37>:    mov    $0x0,%eax
0x0000000000001169 <+42>:    leave
0x000000000000116a <+43>:    ret
End of assembler dump.
