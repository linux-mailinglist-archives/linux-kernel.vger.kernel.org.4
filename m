Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C597D68AEC3
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 08:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjBEHuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 02:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBEHuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 02:50:11 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650FD1EFD8
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 23:50:10 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so8743638wma.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Feb 2023 23:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RGcXZBAIMnr/TsEMbIoAFaGg+i6HpqoM4umiMvHSXsY=;
        b=jlzmcxgR7DmdfFvEvxbNsvYPYITMzruP8BdHF3wGFq/yv/YRpMp1UhDvmP5cwexkl1
         6nhIc8Nvjc8xSVGj3ysY1C9U4pMvBeiLauTFCkJpZRv4eplyWfpPwCKptPnnm5rzwhyV
         CBBiFfJuDGMQOmazph6Xj9bNRnXD6Bu/TMe+NnTg9/re9PSLXIh1dLMaEFxlduEmzgSk
         pvcMHmVj8AvAB0lvnxopAvlrTGd6YRo+Q4jlaAhPepeknID1OVGI0uBHlWJ5zH0kYhU+
         UQ7otS6IBZyuY4CH8RN6/DBqGVGv0n4Ep5ut8CKWcHmXOvEmxGNtTId0/jbH7Wy0UreH
         uHbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RGcXZBAIMnr/TsEMbIoAFaGg+i6HpqoM4umiMvHSXsY=;
        b=dcmiThdXnU3EqdDTANk0QYjm93moo8rAt7vKpkECQpT1RbTd5Eec8JeRnv5XkPQhvm
         OMmmm74MtDDOTfdsnok38MeGAPIRzMd3x5GZJ8ZPN//IS4phO9rnqriuQDxXVEr+JhIx
         F2zfBEyShZtKLoXdPDWXxqHWf6NdkUOFvTcX0nyiNGNMYnusKbYG3uu02py9HJD1A1V1
         tUMLrtFYI0X3sTgiaO1p6tF+lQPX/UaD64oyhR58kPcncLDS2rV7QCMU4xuB/UIB+fQk
         4sMd3SoM2t32naC3XwkkKKuoI51Vs/4RssOtORBaVkGjB4F8Himy71N04tgbht3/Y4Qy
         S9Dg==
X-Gm-Message-State: AO0yUKUYZh9saaFLPEDEPQyf9IoGzbu8S3Yvr4M2yPo3xgl07TvvgS8o
        oIlksTWKKgv3i/9aL9Bj07QNMUfUPiQHLjJn
X-Google-Smtp-Source: AK7set9i3Wg9geRPcKCToiq1uM76wLLsPDmKe6vevpzuS6JFS76d9n+X21n8090RZOqH+jRxfq+XhQ==
X-Received: by 2002:a05:600c:4f96:b0:3cf:9844:7b11 with SMTP id n22-20020a05600c4f9600b003cf98447b11mr17285790wmq.23.1675583408810;
        Sat, 04 Feb 2023 23:50:08 -0800 (PST)
Received: from smtpclient.apple ([109.253.184.159])
        by smtp.gmail.com with ESMTPSA id q10-20020a05600c330a00b003dc3f195abesm7449414wmp.39.2023.02.04.23.50.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Feb 2023 23:50:08 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [PATCH] x86/kprobes: Fix 1 byte conditional jump target
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20230204210807.3930-1-namit@vmware.com>
Date:   Sun, 5 Feb 2023 09:49:56 +0200
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5DFB6E19-210E-4EA8-8D71-66FF4A787942@gmail.com>
References: <20230204210807.3930-1-namit@vmware.com>
To:     Thomas Gleixner <tglx@linutronix.de>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 4, 2023, at 11:08 PM, Nadav Amit <nadav.amit@gmail.com> wrote:
>=20
> From: Nadav Amit <namit@vmware.com>
>=20
> Commit 3bc753c06dd0 ("kbuild: treat char as always unsigned") broke
> kprobes.  Setting a probe-point on 1 byte conditional jump can cause =
the
> kernel to crash, as the branch target is not sign extended.
>=20
> Fix by using s8 instead of char and use immediate.value instead of
> immediate.bytes for consistency.

I guess I forgot to put a =E2=80=9CFixes=E2=80=9D tag, since it is still =
not a real
regression. (The bug was introduced in 6.2).

Still, this fix should not fall between the cracks=E2=80=A6 Please let =
me know
whether v2 is needed with a =E2=80=9Cfixes=E2=80=9D tag.

