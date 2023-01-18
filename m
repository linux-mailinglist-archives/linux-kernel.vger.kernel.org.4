Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239E1671653
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 09:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjARIau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 03:30:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjARI2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 03:28:12 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C0B5085D;
        Tue, 17 Jan 2023 23:53:58 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id vm8so81125102ejc.2;
        Tue, 17 Jan 2023 23:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EDtBCVFGf1WBnDNjRInY00YzbtKsVnedf34v7GhwXPQ=;
        b=mVmK0hLmIV01QDgN4mM8SIJsBXQ4f8who8xoMwEyFJgFwuybTvOZXGlU6y/2+Ndb/7
         Chw/swmDexSbvQP1G3snWgmG8Xw1DW1BV6dHqYblC5GTItujOkZqw1TZTPXqaGiga/k4
         BRyaQQ4mHBxQh9rcJwuKrMc1SwLtLErt6+On0fDntY08ukmZiZ7SlT8kClM6F/phga1u
         BdnHm0249IaxJ214x1ABoZCCE+rYOFZEv/54UUbuuAR3QMEdAbrT57w9LBzQzFIGe4Ax
         XNWMhh8phc3CbYP2V70VjeSdvTO3S44lMijgZcP2cJATQmnh2MTu1esvo7MQ9WMPAciv
         LCXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EDtBCVFGf1WBnDNjRInY00YzbtKsVnedf34v7GhwXPQ=;
        b=ui3/CdZXF1/jfbo0EVdmbG6HMoRwNtDTrD+2c4S8dlIndocR1czoJp8PcG+3ycd5tR
         G+saD0B5p86evPyfTZ3BDp1f0g6+ClLTyLVUj7K69i9qmbRlbz8X5p+JRfgmq166YSYX
         rG1dumur+eWi/kPKZLbBt7wwo34uUSL32iw5/06GbRiaHGnstx63rZVfWEg9TgkMELGI
         PH9CmOsyvSO6+RGo9wpAdLhLU96JLKGTDE8pB61aXlf20zKiIxcJS74xDtwMZAtISJme
         10ZHl/k9eGFJOVUgQW6NSStROZcttqlis2nt/CgfH/md/9t/9qcyKDLHqq8/W7nJXeb9
         TcgA==
X-Gm-Message-State: AFqh2krTkD61d2ZhNp3gauieWTxDOSeUmon6r2Nd2dJfDQPH9XKx8cDq
        ayFrwqJV6XhX/QRKQCqMBNtkY4TbgbrCZYA+510=
X-Google-Smtp-Source: AMrXdXtSbKk6um9A1kJ1Y7LWJlcgVvfL1yQWVL6YxvSibAji/cyrGX2K8YEjriQt954M32fW2qAutQZp/4AeoU5ettQ=
X-Received: by 2002:a17:906:c052:b0:86a:212:56a3 with SMTP id
 bm18-20020a170906c05200b0086a021256a3mr574501ejb.393.1674028436688; Tue, 17
 Jan 2023 23:53:56 -0800 (PST)
MIME-Version: 1.0
References: <20230117110357.15091-1-iuliana.prodan@oss.nxp.com>
In-Reply-To: <20230117110357.15091-1-iuliana.prodan@oss.nxp.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Wed, 18 Jan 2023 09:53:43 +0200
Message-ID: <CAEnQRZAh94s9sHz8EN-u8bgdO9JRo6_-UuTzJNTf=Qi9xPRA+w@mail.gmail.com>
Subject: Re: [PATCH v3] remoteproc: imx_dsp_rproc: add module parameter to
 ignore ready flag from remote processor
To:     "Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "S.J. Wang" <shengjiu.wang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        linux-imx <linux-imx@nxp.com>, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 1:10 PM Iuliana Prodan (OSS)
<iuliana.prodan@oss.nxp.com> wrote:
>
> From: Iuliana Prodan <iuliana.prodan@nxp.com>
>
> There are cases when we want to test a simple "hello world"
> application on the DSP and we don't have IPC between the cores.
> Therefore, skip the wait for remote processor to start.
>
> Added "ignore_dsp_ready" flag while inserting the module to ignore
> remote processor reply after start.
> By default, this is off - do not ignore reply from rproc.
>
> Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
