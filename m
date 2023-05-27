Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46F67134ED
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 15:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbjE0NKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 09:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbjE0NKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 09:10:08 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE4A114
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 06:10:07 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b011cffef2so14988015ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 06:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685193007; x=1687785007;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q62nZveIGkViDlgE3u7tMasS5LHM+Dd3+4pNX3I8rsI=;
        b=I0R9AhPmU7muRDOb5HlY2V4NC6IjqDLT+5Eg9kIfcfrNq7jeIXEJvdDmU+eM8Dd5FR
         5HnerICPAbl7Oyri72XvP4wpOpCW/Tb0DSQFdvR1JkEXvksDyZUryeJvmh/p/e73ufXS
         EShKCRavaCNXubFkV+cL1F+Hw58fDywskHs4wQ5fKoxBvaG5/Vzt0NaFVVfYKlEM2s3f
         Cick1PgdTL9gKqh0yWZ6Q92g0hZCQlZMzB8o52cPKh5mRms4sQi3J8FF5U9quavzOJCF
         kZJtJhPF0bSou+FQtyShdDKkqZdmY9Jr0RtooG5ivUMH/0LecjNdgSUJJr48Pl0MFd3z
         0w3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685193007; x=1687785007;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q62nZveIGkViDlgE3u7tMasS5LHM+Dd3+4pNX3I8rsI=;
        b=b837G6XmXNBr1VUJK/HQfZpRNyFUJEj0vhMVO+MAG/eprYNh6RJimUEb3esLGvwewv
         X/MIzM7eiFILP8bnUaJwWs3s7PESHlN0nBBy6g1/7H00v/h6VU/v0CEhPmyMkc/6bn0W
         kpYKbfYUy+rufOAjKV8PlwIVjfujeEDs3eKhO26e4vLx/G1YKl4cmF1AOKlqgUvmEGVV
         6qQ8Dq2BfMg8p7RPX76Zd+KfyQu1kgrT7lLI1yt5dvnZANeSEgcAjMtrtYhDQ3Rb37xu
         o9LxqP6v+8n1ilB32EyYCZHF4ZA1DcMJwjMjSjATBK9Ny+NZCII/NeUq/NwQON0bkGzn
         LwjA==
X-Gm-Message-State: AC+VfDxnf97yvcWrbOeGfjp5xgBigv9D5mePMHLV6DKCORu6gzhXbDg2
        hBOXdt8EV2d0ZlDCaNwH51s=
X-Google-Smtp-Source: ACHHUZ4NUi8ZQrlAa2puCFWZVyr+uJkNQ0rU5kFkRyZ4mHPb9elR+Fk3UEl79r3BlgSTr5dgpoAaJA==
X-Received: by 2002:a17:902:9b84:b0:1ae:5914:cbec with SMTP id y4-20020a1709029b8400b001ae5914cbecmr6217502plp.10.1685193006469;
        Sat, 27 May 2023 06:10:06 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id v10-20020a1709029a0a00b001b01fc7337csm1889016plp.247.2023.05.27.06.10.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 May 2023 06:10:05 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: [PATCH v2] x86/lib: Do not use local symbols with
 SYM_CODE_START_LOCAL()
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20230527122916.GAZHH3nHk7kkUA7CeM@nazgul.local>
Date:   Sat, 27 May 2023 06:09:54 -0700
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D267C8C1-2606-4AB6-AE1F-951A46A75CCD@gmail.com>
References: <38e24fd4-9213-229d-9919-7ae3bfb113bb@intel.com>
 <24E47178-C177-425F-A8EF-CFFAE22597D4@gmail.com>
 <20230526155336.GAZHDWAFi1FRqq83TP@nazgul.local>
 <0F07EEDB-8A3F-4224-9FF1-43A5300B1B8B@gmail.com>
 <20230526204559.GAZHEahxxnQaHhSUul@nazgul.local>
 <D63AB9E6-BA52-4E24-B8EF-C7B9DB1595CC@gmail.com>
 <e6cd1909-2776-28d2-ccc0-4b3d2d09e9ce@intel.com>
 <49861038-B8CA-4CDD-BD44-73066FF453F3@gmail.com>
 <20230527072338.GAZHGv+no2LZASyLWM@nazgul.local>
 <9A302EB1-308A-4904-801C-DC70D9908E11@gmail.com>
 <20230527122916.GAZHH3nHk7kkUA7CeM@nazgul.local>
To:     Borislav Petkov <bp@alien8.de>
X-Mailer: Apple Mail (2.3731.500.231)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 27, 2023, at 5:29 AM, Borislav Petkov <bp@alien8.de> wrote:
>=20
> Your cocky attitude will get you nowhere. But whatever you prefer.


I am sorry if it came this way, and most like it was cocky.

I apologize. I felt the volume is turned up from your side and I
turned it up even further. I felt that I fell into Dave=E2=80=99s =
=E2=80=9Ctrap=E2=80=9D
(metaphorically) and it turned to be me adapting the kernel for
my needs - when it really isn=E2=80=99t.

Try to use gdb to disasm to address. It does not work. It=E2=80=99s an
exception (to the rule). The fix is easy.

Anyhow, that=E2=80=99s not the point - I just want to apologize. Thanks
for your involvement and support.

