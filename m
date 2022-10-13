Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 671D25FE2EE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 21:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiJMTsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 15:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiJMTsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 15:48:15 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E4318B4A6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 12:48:13 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id o9-20020a17090a0a0900b0020ad4e758b3so2793217pjo.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 12:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U3IcGLKOjvaTyzTUS9C/MMMRO8g7hgaBW9dEJGasaM8=;
        b=rVOUIkeBIqZYAtSSF4eFMOnnrKQe7YDrmDTPcNQ9kmafqVt16/Uv5D4VRyRLR0LHDa
         V+qVnwMJFrCMIJjVTzGVNGpnIncqjJd+TEBJWfnjCe7/gdyfcBM2I/LbPgzyjq8XP+5R
         WVCqz3b1aZbmVDjUF6cnItA4F1L6JQuw4bW7yOjYJ9Q2/EKVt92zwTLvS6jwu9u/d/Ij
         KousLwVqtMDBcWQ+3dhuWXj+AqkSqwclT0JcNnet/WqPnFs9GOFfaFVyCy1ODqkOH0T5
         wMKZFiuSQUWYfIsIMq6KHrRmtnWJvTSNXfw7jU+RV++y1julovLi9iqhAW8mN+WQVFYM
         zPDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U3IcGLKOjvaTyzTUS9C/MMMRO8g7hgaBW9dEJGasaM8=;
        b=vvkb3q+EpraiBaiWpRrBEJvFFsWJV39swJlLKFSMHUCkDxD4UhnET/WmfrrU0xhNuI
         Lnbno8T42Sw14fQYhFoi5ZFC2nIG+Kl5NNKzT4JSdH7wEbMmSWg7t05ioNoDXR4166NO
         xkF4mZuGLwU5VEsnne3IEScx9ifwh4bObjTI8WLmgnL7I0NDeXY134W7P6b+OpKuq/rY
         ePPz+CEj7zYOxY9JXTVT3VLouHp4i9+3hOk8N/aD/psztS1ymn1KnwqTPgajZ+pgbKQo
         8PN5o+KaLorX4rvIkUBniAMCAK1x1iSt08d6z3nzxBm0PiDoNQapv7E1rY/2MR46JPZR
         4lhw==
X-Gm-Message-State: ACrzQf3ayOgbYOiqY8BFzkb11PfwUOEycuGTUzFi2DPXJe4ClbNzJUsK
        YESBVRBDCvDFZQjiSEuU/qp8aPvTFqNfL1FU
X-Google-Smtp-Source: AMsMyM5E1eMkY733vs4tGfT+q+aO2SJAeN8KpMRDCyyBzxVF0WWEbIQQmJkW/TPgfaHD67o/+A080w==
X-Received: by 2002:a17:90b:2812:b0:205:cdc9:2ccf with SMTP id qb18-20020a17090b281200b00205cdc92ccfmr1484044pjb.97.1665690492699;
        Thu, 13 Oct 2022 12:48:12 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id jf15-20020a170903268f00b00181f8523f60sm213118plb.225.2022.10.13.12.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 12:48:12 -0700 (PDT)
In-Reply-To: <20220924070737.3048-1-jszhang@kernel.org>
References: <20220924070737.3048-1-jszhang@kernel.org>
Subject: Re: [PATCH v3] riscv: vdso: fix NULL deference in vdso_join_timens() when vfork
Message-Id: <166569033638.14806.1663998722831611197.b4-ty@rivosinc.com>
Date:   Thu, 13 Oct 2022 12:45:36 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-36ce3
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Guo Ren <guoren@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Jisheng Zhang <jszhang@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Sep 2022 15:07:37 +0800, Jisheng Zhang wrote:
> Testing tools/testing/selftests/timens/vfork_exec.c got below
> kernel log:
> 
> [    6.838454] Unable to handle kernel access to user memory without uaccess routines at virtual address 0000000000000020
> [    6.842255] Oops [#1]
> [    6.842871] Modules linked in:
> [    6.844249] CPU: 1 PID: 64 Comm: vfork_exec Not tainted 6.0.0-rc3-rt15+ #8
> [    6.845861] Hardware name: riscv-virtio,qemu (DT)
> [    6.848009] epc : vdso_join_timens+0xd2/0x110
> [    6.850097]  ra : vdso_join_timens+0xd2/0x110
> [    6.851164] epc : ffffffff8000635c ra : ffffffff8000635c sp : ff6000000181fbf0
> [    6.852562]  gp : ffffffff80cff648 tp : ff60000000fdb700 t0 : 3030303030303030
> [    6.853852]  t1 : 0000000000000030 t2 : 3030303030303030 s0 : ff6000000181fc40
> [    6.854984]  s1 : ff60000001e6c000 a0 : 0000000000000010 a1 : ffffffff8005654c
> [    6.856221]  a2 : 00000000ffffefff a3 : 0000000000000000 a4 : 0000000000000000
> [    6.858114]  a5 : 0000000000000000 a6 : 0000000000000008 a7 : 0000000000000038
> [    6.859484]  s2 : ff60000001e6c068 s3 : ff6000000108abb0 s4 : 0000000000000000
> [    6.860751]  s5 : 0000000000001000 s6 : ffffffff8089dc40 s7 : ffffffff8089dc38
> [    6.862029]  s8 : ffffffff8089dc30 s9 : ff60000000fdbe38 s10: 000000000000005e
> [    6.863304]  s11: ffffffff80cc3510 t3 : ffffffff80d1112f t4 : ffffffff80d1112f
> [    6.864565]  t5 : ffffffff80d11130 t6 : ff6000000181fa00
> [    6.865561] status: 0000000000000120 badaddr: 0000000000000020 cause: 000000000000000d
> [    6.868046] [<ffffffff8008dc94>] timens_commit+0x38/0x11a
> [    6.869089] [<ffffffff8008dde8>] timens_on_fork+0x72/0xb4
> [    6.870055] [<ffffffff80190096>] begin_new_exec+0x3c6/0x9f0
> [    6.871231] [<ffffffff801d826c>] load_elf_binary+0x628/0x1214
> [    6.872304] [<ffffffff8018ee7a>] bprm_execve+0x1f2/0x4e4
> [    6.873243] [<ffffffff8018f90c>] do_execveat_common+0x16e/0x1ee
> [    6.874258] [<ffffffff8018f9c8>] sys_execve+0x3c/0x48
> [    6.875162] [<ffffffff80003556>] ret_from_syscall+0x0/0x2
> [    6.877484] ---[ end trace 0000000000000000 ]---
> 
> [...]

Applied, thanks!

[1/1] riscv: vdso: fix NULL deference in vdso_join_timens() when vfork
      https://git.kernel.org/palmer/c/a8616d2dc193

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>
