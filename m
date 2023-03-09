Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B69D6B22CA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 12:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbjCILYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 06:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbjCILY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 06:24:27 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81530E9CE1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 03:20:45 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id cw28so5522555edb.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 03:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20210112.gappssmtp.com; s=20210112; t=1678360843;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=izJKh1chlJfOLCp9j7kE3DtVQUEzxS301qJOV97jESk=;
        b=mfXIPyOv70PRWiEcV58/WMaRg37PYYKmOIxjEYN2lRbRJpXyGlyWlFK1ACHetTzJFa
         xCSS4R2O+fYyJlZQ9wgcgZHm2HhJVahqEjkMI016uP676mL3wkP1fdGT4XeAZ+Zz1bvd
         osALxVxsvzAF9/lVJdJB2vyDoYPiQZEOs1+Bbjqpdv9sZJ+2bJLulZ//vR0CAc+Emp2+
         E9WTwj+lFBkQ+0YIdmoEMoViaODrFohx2ZFDQojSKPtf4+H8piG2nbkDDOQ3P2VOxiaB
         0V9f3nsCGvGy3n0SBIemlxPltvaR8Jhof1Mo2QCJPMKyJlxOK01FsoktEx/bRrpwCw9j
         ky7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678360843;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=izJKh1chlJfOLCp9j7kE3DtVQUEzxS301qJOV97jESk=;
        b=MXreAfVke4Tpu2hL4cGk1CrMcXISH/DLJr0+dkvDF78XMiW+R7WTDPkS0nR8+B3oMC
         Oo8kz0+qlDHC+or0sasOAHxmDUV3K+X/nh3fvFnWC3P7OMMdn6vPlOXSi1+5BufV3lf1
         9qXqd0Nvd+WPcCb5h7DYyyfbcLV2UM0yjb4nNBGTATcnepm3PPzQRilgovf02NS2d6nU
         BuOk98BxnZ01XBgl58HeFG67K5DxFOOtUQGDPMNK+seDEG6plmMqrcuerkr+NGcH6PpH
         zvF7s+4/YBtOUx1ymsXzGH/s7hMhYGrXmQVngJE5M2V/pmdGDoufPMLUXj1eilDWF2Ic
         tOUA==
X-Gm-Message-State: AO0yUKXUzEMVSEMfuwGwZD9otShlZMj3z6X9gHBy7Mf8WS4gJzopyC1g
        19GyOv4dpfJQTA/y8L+n2ex0bA==
X-Google-Smtp-Source: AK7set8tjjogZVi126Sp1qDlmUvqfCwwjFraJmMPmH6+IRriMFCahlC7dTlkfFjxtjc2yC4P0IKHkQ==
X-Received: by 2002:aa7:d646:0:b0:4af:601e:6039 with SMTP id v6-20020aa7d646000000b004af601e6039mr18851128edr.22.1678360843343;
        Thu, 09 Mar 2023 03:20:43 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id lc9-20020a170906f90900b008e34bcd7940sm8640657ejb.132.2023.03.09.03.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 03:20:42 -0800 (PST)
Date:   Thu, 9 Mar 2023 12:20:41 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Grant Grundler <grundler@chromium.org>
Cc:     Oleksij Rempel <linux@rempel-privat.de>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Eizan Miyamoto <eizan@chromium.org>,
        Jakub Kicinski <kuba@kernel.org>,
        netdev <netdev@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv3 net 2/2] net: asix: init mdiobus from one function
Message-ID: <ZAnBCQsv7tTBIUP1@nanopsycho>
References: <20230308202159.2419227-1-grundler@chromium.org>
 <20230308202159.2419227-2-grundler@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308202159.2419227-2-grundler@chromium.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Mar 08, 2023 at 09:21:59PM CET, grundler@chromium.org wrote:
>Make asix driver consistent with other drivers (e.g. tg3 and r8169) which
>use mdiobus calls: setup and tear down be handled in one function each.
>
>Signed-off-by: Grant Grundler <grundler@chromium.org>

This is not fixing a bug. You should send it separatelly to net-next.
