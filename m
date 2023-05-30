Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F57715CBB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbjE3LLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjE3LL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:11:28 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E92193;
        Tue, 30 May 2023 04:11:27 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-96f818c48fbso802682666b.0;
        Tue, 30 May 2023 04:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685445086; x=1688037086;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Bp+kN9+R6VPVHGT4UQ82DIn456ugaCfbp3LAdJVuq+U=;
        b=S0PEOlOlAGATuI81S60X3YN0ftuC0BPBLzpVY0Qv/+qYcqQk61348l3niEZtj2XED0
         9sBKdbxAQ/j3GPabXz9xQvzhdRCMJh7Y4DTO/rPP3e5HJ9/Am/JUgMtGpaVQEtz9UTrU
         EzX2ZGBr9FtAqbWQMSkHdjiJDtZCiPuUA+Lr9xgqmVtcxw19jMowHj1lcteDuP3t1CMc
         3SBXzSZzVbv06IbFypSQuaVwuGnBeO7uZZy3o93qz52ZVuoS+X+MZaF4S4q6CLwlzNs2
         omNu0JFuFr3yElSfuzqLuYHXgJeYQhs2V0GOC30ue8NUVq1ZQWtcU1Io4nef3cOe0f7L
         rhFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685445086; x=1688037086;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bp+kN9+R6VPVHGT4UQ82DIn456ugaCfbp3LAdJVuq+U=;
        b=iBffHCS6sR3/qvsEp03wp0KFtREnl4mprzeQ2Kceu1OHmsmghT5z5AnUKsCCNLBCtg
         KgkheFUemRwws/hYh8M9guIvtS3AWfn19DMzYiTW2Pl0B9abl7nKUxOCBExI/ekaFkE+
         jhLFP4NJad8uT/bY7QcP2WAP+nuHQXW76B2fsRndueMtrWKJu/JdXe0RQJql6cPiZQup
         NoKIN+3JUEMvFOGtNbxQZNCFCbQVEMeAuKkJ0dBjx1mi0n2ciMRh7sZjo1fS7JwOP8nK
         5Zlzsm1J1N8CCOrF9In06T755QUUNyh5GjDbjbQU05fbBHTa88Zl79uScM7cQgIOvXtr
         8y+g==
X-Gm-Message-State: AC+VfDyVJkWov2GaHMBce2fBgYx8hHiSe2A0BNv94l0hQx8ooKBtg9m7
        1HDuXqARJl4Qq40KFL64dJE=
X-Google-Smtp-Source: ACHHUZ5tG8Ak/glSS5BZk3njWTrwOgIxrB4ey6inFbzvHo8DRSIxjI9RXISBX3cL2sxdzhrGvfiQtg==
X-Received: by 2002:a17:907:1694:b0:96a:1ec1:2c9f with SMTP id hc20-20020a170907169400b0096a1ec12c9fmr1867041ejc.12.1685445085811;
        Tue, 30 May 2023 04:11:25 -0700 (PDT)
Received: from [10.176.234.233] ([165.225.203.148])
        by smtp.gmail.com with ESMTPSA id dk24-20020a170906f0d800b00958434d4ecesm7403625ejb.13.2023.05.30.04.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 04:11:25 -0700 (PDT)
Message-ID: <93839d61500f626e78f8c63b3a11b29ef4f17b11.camel@gmail.com>
Subject: Re: [PATCH] scsi: ufs: core: Do not open code SZ_x
From:   Bean Huo <huobean@gmail.com>
To:     Avri Altman <avri.altman@wdc.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 30 May 2023 13:11:24 +0200
In-Reply-To: <20230530075033.11006-1-avri.altman@wdc.com>
References: <20230530075033.11006-1-avri.altman@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-05-30 at 10:50 +0300, Avri Altman wrote:
> A tad cleanup - No functional change.
>=20
> Signed-off-by: Avri Altman <avri.altman@wdc.com>

Reviewed-by: Bean Huo <beanhuo@micron.com>

