Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBD06FD0E3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 23:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235975AbjEIVUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 17:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235779AbjEIVUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 17:20:06 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A7C6582;
        Tue,  9 May 2023 14:19:56 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-24deb9c5ffcso4436503a91.1;
        Tue, 09 May 2023 14:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683667196; x=1686259196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U2yUTsSYh4P6rDmZ2cLSA1mU3F3qw3C0KhflQYhVRTg=;
        b=e7iGL5jHVtBSIbB0hVQOXoSRC3oreda5HYHrPQJlPSUEkPySTape0TlpPkKwCWAQ70
         YnC4GlZv0WvLptoMI1XRE006QRrtgFFBgZbfnGWygvyy7oRenj61YCir6/cxQFwvL3Q/
         5ETXoYXEfkW0qjjN7cjneCXf0Bn8ljeXiozTrP0+TiEFMdblfx5T24MS4GRonw6UOEjC
         Ixr3QHppe9hfXj79n1/+wqe/nc/YkglgWsipCWurEkbtQxH33c824xTYhxYZwDZmsLn/
         ecAdlvbIVRaJAE8ArktQQK/281cDeC05YH2P1Y+IgRAr7NhKqtfpQIIVqBH2DX+E0Pt7
         EQgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683667196; x=1686259196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U2yUTsSYh4P6rDmZ2cLSA1mU3F3qw3C0KhflQYhVRTg=;
        b=X63jLOEfiCxWoE2ga0v8xCngbkiEViCWgABfLExRc/ymV1BzElFnQYbaSuXC9jA7ap
         w8M4zGueCQZkNCPTUHuZ20wgFlV9yLK+7tMfv572U3ztNfnkddvoUhI5FwNK2zjGYYN9
         wwv6sZVj/9KpkSNyBke5cSnHp5j14yfH5GcucGVyq3JLAKDskdnceVkH8k91H2L/38bK
         L0y8dQ9haLPcER53m50x/oPZpHPKCmnABAeQn4NSXuL+DckzXh6DTqNofeNXtK4lP2bK
         k1jSdz+IPNoFEM4HMoX5FbIf6ddoJDoSW/zu1omOF/RT1vbwWq0p+lvFAnGDNSYCFXQX
         l6Ag==
X-Gm-Message-State: AC+VfDyImoxK8rwe2sy044uaJykr72NYcLYmI0oRrvL0OX0l2cAc7zOH
        lBqDdxEketA6vqeBSwUGRTRUG7R39+c=
X-Google-Smtp-Source: ACHHUZ6pd/LY0/BhziRNHxFzgEW6DwFIOWaiYa0ix7s71nq7Z13gkAn4eoGRRu8WUZLWVBpq3ojmzA==
X-Received: by 2002:a17:90b:3708:b0:24e:1ca2:bf0d with SMTP id mg8-20020a17090b370800b0024e1ca2bf0dmr14657167pjb.40.1683667195874;
        Tue, 09 May 2023 14:19:55 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id fs9-20020a17090af28900b002470f179b92sm12142881pjb.43.2023.05.09.14.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 14:19:55 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: mmc: brcm,kona-sdhci: convert to YAML
Date:   Tue,  9 May 2023 14:19:53 -0700
Message-Id: <20230509211953.1796591-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <a1fd4092b8a31c2ee58a3cd4cca062db13197b45.1683548624.git.stano.jakubek@gmail.com>
References: <88c64da50a1af868d8b14054c440e5ff96a63399.1683548624.git.stano.jakubek@gmail.com> <a1fd4092b8a31c2ee58a3cd4cca062db13197b45.1683548624.git.stano.jakubek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 May 2023 14:46:03 +0200, Stanislav Jakubek <stano.jakubek@gmail.com> wrote:
> Convert Broadcom Kona family SDHCI controller bindings to DT schema.
> 
> Changes during conversion:
>   - also mark reg and interrupts as required
>   - drop deprecated compatible (it's been deprecated for ~10 years)
> 
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian
