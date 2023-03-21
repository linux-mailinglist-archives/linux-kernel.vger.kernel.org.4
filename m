Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF2D6C3C88
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 22:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjCUVTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 17:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjCUVTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 17:19:19 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D4E12F14
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 14:19:18 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id o6-20020a17090a9f8600b0023f32869993so17768648pjp.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 14:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679433558;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VK8OACTsZrCxigEsUC8+yzbwaxLgbM99buzLp5o3QHA=;
        b=KDAujDFlQT0N2rQpFVbd4roL3RWQBYm/O2siIyVzrY7lG/AfI5USHePmZqNACELWyZ
         CAnixP+UM1iiselTENdcf+UGEHR7RjU7v2nh4l8MS9I5rs410vful8xNw1q8a1l48TII
         1Tzk3uBMAd+TwF1zrApmuNi1Ts9xdXFmqeedXAvilKHysph5glkWHJYEVWDmicnq32te
         xjLHW8hqAnrfzXLSsjx7gr9JFW3Is657wdZmV/bWIato4yLeyjXJgVuehH/QRLFzcBli
         TGsAS28JrwpiCe5hck5JukYyZaEK9UOMdkcpfk+cvG5LjIf7XljQvIN3HFH7P5f5dwb8
         XYCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679433558;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VK8OACTsZrCxigEsUC8+yzbwaxLgbM99buzLp5o3QHA=;
        b=dduRUWUMitWDMeMYOVhg0NxGwN1ggd+x10MDWNRxLtd+F56j3sZOdQmgAVd3UDCRPH
         D7RqqtFvnYMbPiaOtehdAmwtTwaUdBTjIBsC1YDQnsgOowzH3157nxbQv7bTYGFTkadZ
         4rvgR8kiIUBm41VaoHzARnWYYXj3JwbpINYxrjX6fd/GVVYrWftpj0rn7aCKYoSh9BVJ
         TmFZBQYFZkkleGqZm6y1EEEnu42ZOlRn3VB3SNGQHMQaQZDcL+nrGxTmi8w4tKLFgK/8
         jQMRMB73ssiWoH1KfpO1A+AgLmySwbxqD5NK1Uv2KZzVoYCk4SSUb5l4UFrFqInifJ6A
         B/OA==
X-Gm-Message-State: AO0yUKV5pzd9VJkPX5lm9vEUZ1XXJDbL6R5qJWGDEZzV1mRbsh3NnwNI
        HPs8F2z3hdBPhWosREiv+JkrXA==
X-Google-Smtp-Source: AK7set+8I755xqwBJMnakxMfyAKZdvfsiqbry9lE2fZAK+7+ZS6/xxDfvgMLgjrrGxPIbY9MdNYOwg==
X-Received: by 2002:a17:90a:49cf:b0:230:b0e3:9cad with SMTP id l15-20020a17090a49cf00b00230b0e39cadmr889584pjm.23.1679433558289;
        Tue, 21 Mar 2023 14:19:18 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:8a45:c131:e8ed:3f53])
        by smtp.gmail.com with ESMTPSA id s19-20020a170902989300b00186cf82717fsm9173146plp.165.2023.03.21.14.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 14:19:17 -0700 (PDT)
Date:   Tue, 21 Mar 2023 15:19:15 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     andersson@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, linux-imx@nxp.com,
        patrice.chotard@foss.st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, arnaud.pouliquen@st.com,
        hongxing.zhu@nxp.com, peng.fan@nxp.com, shengjiu.wang@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] retmoteproc: imx_dsp_rproc: Call of_node_put() on
 iteration error
Message-ID: <20230321211915.GA2782856@p14s>
References: <20230320221826.2728078-1-mathieu.poirier@linaro.org>
 <20230320221826.2728078-6-mathieu.poirier@linaro.org>
 <CAOMZO5Dh0mQEhjT2Wx_T9Kf9aTkNpJ7PbMfocQ24sh+yGtw+ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5Dh0mQEhjT2Wx_T9Kf9aTkNpJ7PbMfocQ24sh+yGtw+ww@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 08:02:04PM -0300, Fabio Estevam wrote:
> On Mon, Mar 20, 2023 at 7:18 PM Mathieu Poirier
> <mathieu.poirier@linaro.org> wrote:
> >
> > Function of_phandle_iterator_next() calls of_node_put() on the last
> > device_node it iterated over, but when the loop exits prematurely it has
> > to be called explicitly.
> 
> Typo on the Subject: s/retmoteproc/remoteproc

Thanks for pointing that out, I'll fix it.

