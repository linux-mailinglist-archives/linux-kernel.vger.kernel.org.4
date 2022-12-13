Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1ABF64AFBD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 07:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234392AbiLMGSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 01:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233688AbiLMGSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 01:18:16 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76701CFEE
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 22:18:15 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so2445983pjs.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 22:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iTFwDLlgOeHNI6Dm6jsm1vXO5FMUxek2Gk3N4ANJmq0=;
        b=L7TybuH5LCvauKz7RjNOVfsdBWSD+n0aqdrISEaq2OHQfkDU9FKrTF8LZcCDdD21ff
         7gypu6ZBfxRWGxy93IrFWhnnkdFkMhtkhlP+ThDrDhUyvSmL4bJ72VoxqY/y4tFcZalz
         LH1eV5OaG0EzHxfHQIxEmkskjAQ0pv6eNmBlWfMfU9W1SArcQC3szuAi9JoND4OCOlWk
         gv8H6aumST9gVWpB6QlAIpQbr9JzqvKmwfT3TqFpAjj/JRZSCzhnHj+C6NObq4m+D3zM
         72r6PdB0AInVk0rsLcPhr9tthOCBGTUvXQRnIwhyk5CQn0Ez7a3r2e92ytRu1yzAKmOB
         AHMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iTFwDLlgOeHNI6Dm6jsm1vXO5FMUxek2Gk3N4ANJmq0=;
        b=j8Qm7hM3l6wuX46ZGR9XAlTbPQRSw3CnufuiUsbi01FLNu/71s4+5pZ+i57HaSjpYh
         zphO01TxVOKZrIaJzhD4d2JTzYpc0RLvbXo4k9oEl0cuMQ54jkq7JGWkyMWdsHR/oCmD
         6yaQWdaMfxLQQnx51Z6vz6fRMFcK3ZI+0G01CsY3rr+vftSb7US4sfd90kMREJsdT3RF
         cMpMI3RLNYZotw8ec9DZqiGOA/MmZdcGcejV/AUF06604JvUPadkFLZm6AHSrGlWj1Z3
         9wFHCeZA/xROzxpvHbJxkZrO+d8ZMqWRdsoc44jYNzEbGvzbMKL53F3woM6/EwmpJCmC
         1FsA==
X-Gm-Message-State: ANoB5pmPoWjcyH0bFW25Aai0pdDZs24aOtETj7w9ty5C43untTIR88c0
        IDCLS+1AHYSahnu6hVPcSCjysA==
X-Google-Smtp-Source: AA0mqf6QQtTaJV0DxtM+FDl7C4MFq1SNb6ynvXzoEP/xJIaw5VGSi0FaAUA8wDa6ThumgMSNngqUBA==
X-Received: by 2002:a17:902:d509:b0:189:b0fe:d70f with SMTP id b9-20020a170902d50900b00189b0fed70fmr24668449plg.60.1670912295171;
        Mon, 12 Dec 2022 22:18:15 -0800 (PST)
Received: from localhost ([135.180.226.51])
        by smtp.gmail.com with ESMTPSA id jj12-20020a170903048c00b0018996404dd5sm7500941plb.109.2022.12.12.22.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 22:18:14 -0800 (PST)
In-Reply-To: <20221130023515.20217-1-palmer@rivosinc.com>
References: <20221130023515.20217-1-palmer@rivosinc.com>
Subject: Re: [PATCH 1/2] RISC-V: Align the shadow stack
Message-Id: <167091227726.18364.8127808951641932846.b4-ty@rivosinc.com>
Date:   Mon, 12 Dec 2022 22:17:57 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-e660e
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>, jszhang@kernel.org,
        linux-riscv@lists.infradead.org, guoren@kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Nov 2022 18:35:14 -0800, Palmer Dabbelt wrote:
> The standard RISC-V ABIs all require 16-byte stack alignment.  We're
> only calling that one function on the shadow stack so I doubt it'd
> result in a real issue, but might as well keep this lined up.
> 
> 

Applied, thanks!

[1/2] RISC-V: Align the shadow stack
      https://git.kernel.org/palmer/c/c3ec1e8964fb
[2/2] RISC-V: Add some comments about the shadow and overflow stacks
      https://git.kernel.org/palmer/c/de57ecc47610

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>
