Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDEC765F713
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 23:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236311AbjAEWww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 17:52:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235947AbjAEWws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 17:52:48 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0DE58823
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 14:52:47 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id v23so41406099pju.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 14:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t+1Y716yohfg2jJGDpC9Mm0+rOnzxTQAu/sHCuPL2KM=;
        b=cSFo5FtDyzZrfSrtCo1vjOfuJZcmya6aX4EMIfNS1PiiCCw8R8o6I4HXTDYLIFPD7G
         l6oqGMbt8PyZ6OwKyzxMZfbegOurfyE/nUvQwzhwpYrbXneMJHC7wMS6T688rCg3BHQq
         ILn9lAG7Tl7mqlTkmwqzx0WU2uUPUWJRYYefxW3UqcEjt710QNf5GoYxx4Aj3sVlKihE
         zSt5dylARz/0v5Cr4sZDwibB0ttSeZDIXpL9HhwsGN1TBaRbHC4AMOe6qpo7Ivgp29Mu
         /zy4X3C2I8XT42IZoAOT57ZN9grxz3SLI/yK2+ksRsmHZiTSQqiYeqtIjmQMPsXN7CTa
         Gspw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t+1Y716yohfg2jJGDpC9Mm0+rOnzxTQAu/sHCuPL2KM=;
        b=od0+c75lQ9cLviYAz4tfHZV93FyjGt5gceVIezB1o/mzCqmXCC14tx5Hk7VU9CYErT
         /2dzvaTIVxYTVQ0k+KuekKSY9x9sT1vLMiS8v3QeMT92OcOspPgayRtJuPR4CPCR4lcL
         0jFzAtYp+dmQy2yLlhdQ575wd52wkYZ6yLO4VfvNghZhL17fblhN5D/dbrA8fTR337vn
         2IFryCawuOND1Uo7T0cFw1JtNfP4ftXlyz9Pwrpeb2HS5wVnwZfg215SZen3IlobuERf
         i7BI1kEGA8I5GJQHzfTsF0CRoDS6V67anuIvsU2t45kRDEmbQj1C5/JT9g57GONdNW62
         GwoQ==
X-Gm-Message-State: AFqh2kpZHvaRL1iolYNp3sYZBl8WbLbYxoQVzzSWYEFyZkzq/KAQmj5p
        JEwqaUKPoGH/ZuqA4DuH4Q7Dkg==
X-Google-Smtp-Source: AMrXdXsoKJStIchx2BZIfo8Eg67U5VNU3bl12wCIA53l5gcY0eYpsbkfTpGyQx0osjXFjVIhrppiVQ==
X-Received: by 2002:a17:903:50e:b0:189:bda4:4a39 with SMTP id jn14-20020a170903050e00b00189bda44a39mr52342354plb.49.1672959166962;
        Thu, 05 Jan 2023 14:52:46 -0800 (PST)
Received: from localhost ([135.180.226.51])
        by smtp.gmail.com with ESMTPSA id j2-20020a170902758200b0019269969d14sm23675642pll.282.2023.01.05.14.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 14:52:46 -0800 (PST)
In-Reply-To: <20221229170545.718264-1-ben-linux@fluff.org>
References: <20221229170545.718264-1-ben-linux@fluff.org>
Subject: Re: [PATCH] riscv: uaccess: fix type of 0 variable on error in get_user()
Message-Id: <167295914585.11542.3959390296046499334.b4-ty@rivosinc.com>
Date:   Thu, 05 Jan 2023 14:52:25 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-e660e
Cc:     aou@eecs.berkeley.edu, Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     linux-riscv@lists.infradead.org, Ben Dooks <ben-linux@fluff.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Dec 2022 17:05:45 +0000, Ben Dooks wrote:
> If the get_user(x, ptr) has x as a pointer, then the setting
> of (x) = 0 is going to produce the following sparse warning,
> so fix this by forcing the type of 'x' when access_ok() fails.
> 
> fs/aio.c:2073:21: warning: Using plain integer as NULL pointer
> 
> 
> [...]

Applied, thanks!

[1/1] riscv: uaccess: fix type of 0 variable on error in get_user()
      https://git.kernel.org/palmer/c/b9b916aee671

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>
