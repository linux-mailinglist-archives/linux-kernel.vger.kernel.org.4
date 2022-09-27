Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE635EC747
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 17:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbiI0PK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 11:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbiI0PKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 11:10:23 -0400
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549F61AF23;
        Tue, 27 Sep 2022 08:10:20 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-12803ac8113so13656988fac.8;
        Tue, 27 Sep 2022 08:10:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=01hEAkY1hMZUkwcBVy5mGusCts5qnC2yIn3xsipxquI=;
        b=PbzJN576EireVHTK/eCYrEUDcQ46N8P6L9WvbmElKcTKN17ipe64tgFMqsKs5gnoBR
         9ekLhxN6jJEZU6M7a7rq+zdaFJyeaki3Igqpqz/hkw4QRpt99cpDIy/uoPMQOJ4+P+eG
         pF54cb5qfXwKXusijIyGkyQVwat50cBJLJTSUD7Dq8jbS4pD8M2NJ8AvFfp4OhH1AXcw
         0A7hGtro8frNRavy1pXLW4ON2nqr0riVBYiV1jAahnFvCfF1fVXIxYZ8Pz4x5jWbh9gw
         tM/WdIuzkeFvr75SZtsjHUNa18MZ7fX0QutB2Mkhy9GzIQv4d6GNKXZPMyytHPCmBp3/
         5+AQ==
X-Gm-Message-State: ACrzQf34Y8+xrBx5aJ8bTDKWjXylrVkf0mSmIP496hVYz6+1lVk2kYCC
        UqdIAFd/8iUoC3hkw4jFjw==
X-Google-Smtp-Source: AMsMyM66lHwKEQ473dWPH2HWqmnDEcxhSbVpH7P6xCNk3/33RnDl3cG96wIPt0dQhAv2wSmYzPtQ9w==
X-Received: by 2002:a05:6870:65a5:b0:126:e94e:926f with SMTP id fp37-20020a05687065a500b00126e94e926fmr2377774oab.230.1664291419464;
        Tue, 27 Sep 2022 08:10:19 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d186-20020aca36c3000000b00342ece494ffsm666372oia.46.2022.09.27.08.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 08:10:19 -0700 (PDT)
Received: (nullmailer pid 1096523 invoked by uid 1000);
        Tue, 27 Sep 2022 15:10:18 -0000
Date:   Tue, 27 Sep 2022 10:10:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Rob Herring <robh+dt@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2] kbuild: take into account DT_SCHEMA_FILES changes
 while checking dtbs
Message-ID: <20220927151018.GA1095814-robh@kernel.org>
References: <20220915114422.79378-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220915114422.79378-1-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Sep 2022 14:44:22 +0300, Dmitry Baryshkov wrote:
> It is useful to be able to recheck dtbs files against a limited set of
> DT schema files. This can be accomplished by using differnt
> DT_SCHEMA_FILES argument values while rerunning make dtbs_check. However
> for some reason if_changed_rule doesn't pick up the rule_dtc changes
> (and doesn't retrigger the build).
> 
> Fix this by changing if_changed_rule to if_changed_dep and squashing DTC
> and dt-validate into a single new command. Then if_changed_dep triggers
> on DT_SCHEMA_FILES changes and reruns the build/check.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
> 
> Changes since v1:
>  - Fixed the quiet_cmd_dtb to fit into the 7 chars limit
> 
> ---
>  scripts/Makefile.lib | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 

Applied, thanks!
