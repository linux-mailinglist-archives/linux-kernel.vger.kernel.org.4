Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58B5624DC5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 23:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbiKJWq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 17:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbiKJWqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 17:46:47 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A8A51C3F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 14:46:46 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id d59-20020a17090a6f4100b00213202d77e1so6221628pjk.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 14:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=88wxF7EFPI4oVF6TP1DUCBFSPf8iLofiNlQTDEC/2/E=;
        b=Bd5wnWlpK7G2yQB6xFMcBNaY19/+Hp53I5ByjmFSt7jOjwEMxLP0JeT2nEgmOmC6gf
         HAgp09tEWNs90/tiLbjVKe/lt9EJcH+6Lso1skB9teTnLw3NUzHiKFhiHrMHLYXsdivC
         5xseIPqqfCxv5oPrUDNJN6i7kt0y6BQZu/tlPa/qi3nBumpu907ktTSyswJOpr7zEOhL
         6VoiGP6cmaUIcaadSOhJ503SM/I9w2mxfm/tsv4PnDxn1h++dnmAh6JfRv/5OqhQb09l
         qY9lKQP5kO/lt/hsgIt61hStPeA0it03UGeS6fey4Wa93SllNYAk9DUodq1IqEjMGD+y
         8SvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=88wxF7EFPI4oVF6TP1DUCBFSPf8iLofiNlQTDEC/2/E=;
        b=CVm66n0iOz8GARVKKpEHA/PW/EIrSU3Rf07JBsSJn9NPh0A0NayfH39RW2M9KtrDv9
         QS4wUWMruA9rtoCk3B4I1p7O6wKkk6bKtynNNZG/PBpgsJf7U0n5rTtE0w4XrcT1Qscf
         ZH9NvLboQZgYfX7PhcZGOahguQLeI8SX2fm1Ukb/ZLO3mBHpH5DAbArorXIQR1fuhLqg
         Jk3Vke69CSrJMc8pwssDCUsnpCQKcPYilqhT1huZ5+9wF+3fqlzuPdHp3ycXssS9f3z7
         3B/ZYvQqDwUTCKhaQbA10xO45Hbelo4pL9m/vhZZvpAwuT8kfDCdq9oJ8xgDFgmE89Nq
         PpQA==
X-Gm-Message-State: ACrzQf33Vqu01fWiqeAM2BdJDIdJW6NgOzgSVM31zZO7BuJpboC3YlTY
        09vUyDhROiYGAjoRIh0tZNNIK6nq0Yql4w==
X-Google-Smtp-Source: AMsMyM46dMjtYOYxxhT+H8nuIspDfW4PXlfp8Sw3+5OSXjBnHTEwH17yXbjSY2l2DcZdiITD0hVxew==
X-Received: by 2002:a17:90a:dc04:b0:213:8126:867c with SMTP id i4-20020a17090adc0400b002138126867cmr2361274pjv.183.1668120405202;
        Thu, 10 Nov 2022 14:46:45 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id om8-20020a17090b3a8800b00216df8f03fdsm3594817pjb.50.2022.11.10.14.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 14:46:44 -0800 (PST)
In-Reply-To: <20221029113450.4027-1-jszhang@kernel.org>
References: <20221029113450.4027-1-jszhang@kernel.org>
Subject: Re: [PATCH] riscv: process: fix kernel info leakage
Message-Id: <166812034327.20280.16820301693244403901.b4-ty@rivosinc.com>
Date:   Thu, 10 Nov 2022 14:45:43 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-36ce3
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Oct 2022 19:34:50 +0800, Jisheng Zhang wrote:
> thread_struct's s[12] may contain random kernel memory content, which
> may be finally leaked to userspace. This is a security hole. Fix it
> by clearing the s[12] array in thread_struct when fork.
> 
> As for kthread case, it's better to clear the s[12] array as well.
> 
> 
> [...]

Applied, thanks!

[1/1] riscv: process: fix kernel info leakage
      https://git.kernel.org/palmer/c/6510c78490c4

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>
