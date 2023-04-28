Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84BB26F2019
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 23:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjD1V0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 17:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjD1V0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 17:26:17 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD401BFA
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 14:26:16 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-54fe25c2765so5586717b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 14:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1682717175; x=1685309175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MB4pRYDWGHCoEug4oV/Gp9ElSpzYR1+x4ZuG7TUCNeE=;
        b=EqhmJ0Dm53HDEsKFDodCPoug3IiXWFCKDCSofuievy2UT9YELSYmo5Uh5YjqOS7Grc
         DuDy3wVe5DCjyGlCipRhlI5GX9MoSn3jiSZU8ZCcl1dqU0vdsUdSVRhcN/1/iUsGCUIS
         mEVMXvOnrXYsqRywDuVGgerElqd6xXxWqG/N8s4Fq69sTTB08CFhgayyiU78fk4ShDMI
         wEFkcyq120c27TX0ONNXK/spH+FrAX6kHFay8ENQ2qEgv2Oo+HQW4Ip8bvYDkenySAZC
         JVfX2zGG/YMXn92Xa3H7olDTGqGBNjiYfjD9/b/iL94q8WVS0TvG57DDtbl+u6iIgja5
         F8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682717175; x=1685309175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MB4pRYDWGHCoEug4oV/Gp9ElSpzYR1+x4ZuG7TUCNeE=;
        b=dFcA5PofPC/2LP3kxjoCnP693hM8ePcTGShaXhgveyKM01nPNYXxDRYnfU4FRatFLX
         XfD956AEWI69nXbDqWb27s9I4FAsQiwjjvVaWWwc8opMj/wFuAUTSITqw5BmczKayKLC
         V1Mf1P+wyqaGH1MTzibEQ4EtZoIUBby+kSSPPyxa4fFImcVwXEt3m70OFzLl4KZoxA/A
         i3GNrrEHuSF08Hw0t1bLepw8zUlCKBg3jlhckeTvhkj4aVGsHvmtLPbd51GhLTwWi0b6
         Aev+G9wvrcZnpDTxo89zumnpEM2MVnlbpg3dXw7M+ypSFeCRigRTJVUihjnPUd4uOd27
         ZQAg==
X-Gm-Message-State: AC+VfDxHo0842d9kqKO93YEflkEFpBggUl3BdBLhWu13/qMEBHBv7ksb
        itBY8dn3B+qiHFpAbMCJOk3a1kl1Gd+yJo0jijvF
X-Google-Smtp-Source: ACHHUZ4FDHQXacpr6bGwl+UvwSvk1DsPyxV3dTTRLMSqa+qEMduILcJqzgPLfrIYsck/+cx382avI8YiVsho3LWRhec=
X-Received: by 2002:a0d:df42:0:b0:556:1988:8019 with SMTP id
 i63-20020a0ddf42000000b0055619888019mr5119957ywe.20.1682717175564; Fri, 28
 Apr 2023 14:26:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230420215331.88326-1-junxiao.bi@oracle.com> <20230420215331.88326-2-junxiao.bi@oracle.com>
 <05b3eebd-7a3f-13d5-1fe9-8f4ab3080521@oracle.com> <30ab7555-8f36-cfb7-9101-0ebb92af3c2f@kernel.dk>
 <6300a33a-9d3d-42a2-d332-81e02d52d310@oracle.com>
In-Reply-To: <6300a33a-9d3d-42a2-d332-81e02d52d310@oracle.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 28 Apr 2023 17:26:04 -0400
Message-ID: <CAHC9VhT2uCc5ePi+ung+rLaDiLCCCF=fjq8G+D3FJf0i4E8_hQ@mail.gmail.com>
Subject: Re: [PATCH V4 2/2] blktrace: allow access trace file in lockdown mode
To:     Junxiao Bi <junxiao.bi@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-block@vger.kernel.org,
        nathanl@linux.ibm.com, jmorris@namei.org, serge@hallyn.com,
        konrad.wilk@oracle.com, joe.jin@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023 at 12:33=E2=80=AFPM Junxiao Bi <junxiao.bi@oracle.com>=
 wrote:
> Paul,  do you have any other concerns regarding blktrace? As Jens
> mentioned, blktrace just exported IO metadata to Userspace, those were
> not security sensitive information.

I think this version of the patchset is much better, thanks for your
patience.  I don't have any further concerns, and since the lockdown
LSM doesn't have a dedicated maintainer I think you should be all set
from my perspective.

Since there are no changes under security/, I'm assuming this will go
in via the tracing tree?

--=20
paul-moore.com
