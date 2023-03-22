Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7E56C533F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 19:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjCVSGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 14:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCVSGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 14:06:14 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182565F511
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 11:06:12 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id m6-20020a05600c3b0600b003ee6e324b19so1278164wms.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 11:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679508370;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lQlkTrDUMyIzoKUTa4EB/7B9v75JQsqp1RH/FF8jnII=;
        b=Jv/yvvCIK9N/w4adbeYydlyMQukdDjPsjhHiWZML0YgwHCbjb3oWOXkMDFxGyqMis8
         Y9heDgxww1MEfpFHUHbwP0+f5jLcaW+lya3SGPkHXFDVCkSUmtPUWislMayCeqMO30XH
         lhtp92ZYe8zWEcMgnIa7he4GgyY0BNZlnTviZo+Mx/QgMI5nOlfPk3RQ5+Krm1+xz2p5
         KNChmEF2+Z2rtzSv1qxpfsv1gjGaZN+4SRWEJG/Tjqy54RjC5lPCIbFdaVrhhFyWn8Jz
         Seel55pLxPkZwgva2ld/t+h7CzF9tf24k1sfrvuLA+0jSGj16Z0X6bhLzfzOkV8PvCW1
         VxTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679508370;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lQlkTrDUMyIzoKUTa4EB/7B9v75JQsqp1RH/FF8jnII=;
        b=fLjN3oyGGwwFbI5H/r+Zszw2Wrx6qkrVxvUbep68KD9UcuqYPG3rvPfcQISnMF9fKo
         ab5pZO4g9yHjh6D84ZY1h5w96CL9Fn+u8AnZZIpf1RQ29YHc4YiQRXEdMp/vCCzmvezt
         j3iBYkq/CbxIgdlXFGhYx6qVspRASC+YT3oh0gsgxsG+RWI0vLGBY+F9c5miSTWJQVoT
         /89kgM9d3aKsPjKRgqZTOuTO63InXaqfVy7v/LQrfumveO47l3QmOOnnbXwy2Oqm3jWD
         ilDOxxWV4UzVarKTM/HZ3Ox5F4Svq1GwtDPrbKqkB3Nvg5gVS9g3Z5SN/7f5xNgMRzc2
         uMWw==
X-Gm-Message-State: AO0yUKXlgR7JvjKgbig+ANanulOd80hRi01EbUD2cKzKhvl5/OaroKG/
        DRJ3ei/5VcMgzudRj0pU0rv9MPmYA+NrxrvS
X-Google-Smtp-Source: AK7set9PvLALfTOZlyrn4wUsytwFilchVUKkUSnU6OXEoe2fBm9qiDZfKWrdnLEWV8TmcajiZO9Urw==
X-Received: by 2002:a7b:c3d9:0:b0:3ee:42fd:7768 with SMTP id t25-20020a7bc3d9000000b003ee42fd7768mr372051wmj.1.1679508370151;
        Wed, 22 Mar 2023 11:06:10 -0700 (PDT)
Received: from khadija-virtual-machine ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id j10-20020a5d464a000000b002cea8f07813sm14452324wrs.81.2023.03.22.11.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 11:06:09 -0700 (PDT)
Date:   Wed, 22 Mar 2023 23:06:07 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     Dan Carpenter <error27@gmail.com>
Cc:     outreachy@lists.linux.dev,
        Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
        Christian Gromm <christian.gromm@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: most: fix line ending with '('
Message-ID: <ZBtDj/sRJCiOhsRD@khadija-virtual-machine>
References: <ZBsYYAc1Ue/JnUAm@khadija-virtual-machine>
 <8064a4ee-665b-417e-a1e2-7e7dd32ec1f0@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8064a4ee-665b-417e-a1e2-7e7dd32ec1f0@kili.mountain>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 06:09:50PM +0300, Dan Carpenter wrote:
> On Wed, Mar 22, 2023 at 08:01:52PM +0500, Khadija Kamran wrote:
> > Splitting function header to multiple lines because of 80 characters per
> > line limit, results in ending the function call line with '('.
> > This leads to CHECK reported by checkpatch.pl
> > 
> > Move the function parameters right after the '(' in the function call
> > line. Align the rest of the parameters to the opening parenthesis.
> > 
> > Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> > ---
> > 
> > Changes in v2:
> >  - Changed the description
> > 
> 
> No one replied to the v1 of this patch so it's not clear which of the
> patches should be ignored.
>

Hey Dan!

I created a patch revision without any feedback. My bad. I thought the
description in the previous patch was misleading, so I wanted to change
it.

> Also you have a couple patches with the same subject and that's against
> the rules.
>

I am sorry about that. Kindly guide me here. 
Both patches are for same driver i.e. staging/most, but for different
files. Would it be fine to add file names in the subject to
differentiate them?

Regards,
Khadija

> regards,
> dan carpenter
> 
