Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562086FD134
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 23:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236170AbjEIVX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 17:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236164AbjEIVXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 17:23:15 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6320376B1;
        Tue,  9 May 2023 14:21:07 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-24e0c29733fso5880733a91.2;
        Tue, 09 May 2023 14:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683667241; x=1686259241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DmdnewO27aEHf2ZZMGvtb/RdC++QtXOEp6FPHzvlObw=;
        b=GrP0erZP30gZkUMHAXSJYnW7HzP0WBECikLQVt4w52k9vjSJwh2hxfkZhymeVk1quL
         aJnNy+Ty1EYmmZAX8ODrFkyzLFFDXWuWgpbJaCT4ca1558CMbScCS8sSnkmrQTRXbnj+
         Hzkp0bsfILthOfSwBOkpqbZULj2pyiFqPVgUV1LNOCnu2uViRmXKXFmZk33n65/rH8h5
         aP9zQvfy27lCh/nuE7GtvyiUiCkUAr4nIIgTB8WdljK08O5Ved2nh5R9dXpNpy+tpADY
         Dr9fASWE4KLQvGkwANi3vJtHrdNSA9a5gEswlOVvCFhCAf4xOIJ1Bitftb9fMYn5vrDA
         MsWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683667241; x=1686259241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DmdnewO27aEHf2ZZMGvtb/RdC++QtXOEp6FPHzvlObw=;
        b=QfZQfabuRzoh++KEgOe+tRNSw8tpJgzO66AWZ4n57JtTQ6ur09umtx5rNdUv954uWB
         Fiehio15Vnjy5rdpvB8k2SbQhkCQxP7lS4f9zEBTMrklM/l8smj9azChWjHvtS8J7zRA
         IlflDq2zGotElVZhdbQ3RK52MqWt+TvzR57n1gJXAYWmo7Ff2L+Z8gy9Ndw0xdYeGrCr
         nNg9j2Ya7RvJFhGziacjt9m6sLSnXmaioBHJmi6RaEZGSr2WYgnL8n7pAWwnm/S2v0Yz
         IqAFHj4tOgHoSZB8fqMkWjYKL0GZg2JlB2E9/tYA8k+n+lf+oQERO4qCa9sZRcbxNh6v
         FWzA==
X-Gm-Message-State: AC+VfDwAqDiKWKNf0fs4vh6AHvxRQZGqiShQ2MqkX2n9sMJQ7MPdVuwf
        zX+/wy0ylPXgL2gQFeofSwA=
X-Google-Smtp-Source: ACHHUZ7rxTAmDXso1N4AHbAWQ/NrmPzCUc4buimqHKrt4zWOf8EbUxl5IxNc6grlGbQgtut3XqfSIg==
X-Received: by 2002:a17:90a:2981:b0:247:6be7:8cc0 with SMTP id h1-20020a17090a298100b002476be78cc0mr14770174pjd.35.1683667241180;
        Tue, 09 May 2023 14:20:41 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id cl2-20020a17090af68200b002465a7fc0cfsm12277848pjb.44.2023.05.09.14.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 14:20:40 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: dts: bcm-mobile: align SDHCI node name with bindings
Date:   Tue,  9 May 2023 14:20:39 -0700
Message-Id: <20230509212039.1796704-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <88c64da50a1af868d8b14054c440e5ff96a63399.1683548624.git.stano.jakubek@gmail.com>
References: <88c64da50a1af868d8b14054c440e5ff96a63399.1683548624.git.stano.jakubek@gmail.com>
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

On Mon, 8 May 2023 14:45:32 +0200, Stanislav Jakubek <stano.jakubek@gmail.com> wrote:
> Bindings expect SDHCI/MMC node names to be "mmc".
> 
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian
