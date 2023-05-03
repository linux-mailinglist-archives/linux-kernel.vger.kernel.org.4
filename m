Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718D16F5DF8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 20:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjECScz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 14:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjECScr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 14:32:47 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975044684;
        Wed,  3 May 2023 11:32:43 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f1cfed93e2so55859105e9.3;
        Wed, 03 May 2023 11:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683138762; x=1685730762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tnjo0GPsUMLtbgipB+jFFEAt1dS72xwdMdksvi1BCQo=;
        b=N03XwXpKNA2E1AUBC6mLwh7IMQ3fgeBYZTE4GtUw72lpmBKmC90XKEyJl1Z04uY/rr
         UGsBqkO+xBL9B8hAqSwl3IiPjwSHcKiO3ec3tdpF2X74MM7pdbW9zdvI3yzo/Q/uQ1EH
         s6XKmx51/vtYZibFlH62zbdrsvCqld3oWPeL3KFkevvVf0ajts05yrZK1b3BDYEYmjte
         Zdig5Mzxh0EysPCPG5uWFQpYYleWHY5xbxrDHCru6m/A2bDofRex/QmEC/jpNmuEOEwD
         SPqrQGZjJbPDHKrbIrSSjo0II+FZ9yPpsFWePIbejQdeRNqgHET52I74M42scAdsA/qF
         vsZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683138762; x=1685730762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tnjo0GPsUMLtbgipB+jFFEAt1dS72xwdMdksvi1BCQo=;
        b=i8sNwEon37uHIwFGXLZHpsVAUReQjxpKsBhOBib03GnfSR9oqp3Gj/iswJG8t02/1k
         fxsbmHBWVN1apLy/t+fW3sqe9eHeSk+jTLhxL3iUMu7DKXq/5Zo3UMgEuHHL+1VQw0Cw
         wpir1iFC8txBWGPTL75C8zKepyvrJiRKUfPKcJJ7+ahMJHop3BT6fmY8e32ZA0gBoRHz
         +GUevrvd/5ZlX1A7TMtMSs7k4meCJ1fd2sqKz/pfw4BxQBUtB5in25DYx/PG1QI1WBQ4
         +b1ro1yUve1d1uCGOD2+voSJBTLk/GpNfJ7Qs8AN5jFFxDLQ5sVyVqYV1eLEOdqEvwTZ
         o2Zw==
X-Gm-Message-State: AC+VfDwznGjwzMiwxLKjFJw214YZzqvyESahIjHQeWZ6oBei1pbpPf9J
        a32nnwIhBdqOdg1dbQkbchk=
X-Google-Smtp-Source: ACHHUZ7V6piwmo+mncPslAtNBLQcTTdJZ12eIjuFrRAkrUryjv55B7xSqgs01e2CBQt/D1REoH8YYg==
X-Received: by 2002:a05:600c:b41:b0:3f1:79ad:f3a8 with SMTP id k1-20020a05600c0b4100b003f179adf3a8mr15676745wmr.16.1683138761885;
        Wed, 03 May 2023 11:32:41 -0700 (PDT)
Received: from suse.localnet (host-212-171-7-24.retail.telecomitalia.it. [212.171.7.24])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600012d200b002ceacff44c7sm34635164wrx.83.2023.05.03.11.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 11:32:41 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     raghuhack78@gmail.com, Raghu H <raghuhack78@gmail.com>
Cc:     linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        ira.weiny@intel.com, bwidawsk@kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] cxl/mbox: Remove redundant dev_err() after failed mem
 alloc
Date:   Wed, 03 May 2023 20:32:37 +0200
Message-ID: <3235466.44csPzL39Z@suse>
In-Reply-To: <20230428012235.119333-2-raghuhack78@gmail.com>
References: <20230428012235.119333-1-raghuhack78@gmail.com>
 <20230428012235.119333-2-raghuhack78@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On venerd=EC 28 aprile 2023 03:22:34 CEST Raghu H wrote:
> Issue found with checkpatch
>=20
> A return of errno should be good enough if the memory allocation fails,
> the error message here is redundatant

Typo: it's "redundant". No problem, I think you shouldn't resend only for t=
he=20
purpose to fix this. But...

> as per the coding style, removing it.
>=20
> Signed-off-by: Raghu H <raghuhack78@gmail.com>

Is "Raghu H" the name you sign legal documents with?=20

If not, please send a new version signed-off-by your full legal name.=20
Otherwise... sorry for the noise.

Thanks,

=46abio

> ---
>  drivers/cxl/core/mbox.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index f2addb457172..11ea145b4b1f 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1112,10 +1112,8 @@ struct cxl_dev_state *cxl_dev_state_create(struct
> device *dev) struct cxl_dev_state *cxlds;
>=20
>  	cxlds =3D devm_kzalloc(dev, sizeof(*cxlds), GFP_KERNEL);
> -	if (!cxlds) {
> -		dev_err(dev, "No memory available\n");
> +	if (!cxlds)
>  		return ERR_PTR(-ENOMEM);
> -	}
>=20
>  	mutex_init(&cxlds->mbox_mutex);
>  	mutex_init(&cxlds->event.log_lock);
> --
> 2.39.2




