Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7BB68053F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 05:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235659AbjA3Etl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 23:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235650AbjA3EtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 23:49:04 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84CD4202;
        Sun, 29 Jan 2023 20:48:54 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id cl23-20020a17090af69700b0022c745bfdc3so3347484pjb.3;
        Sun, 29 Jan 2023 20:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vuf6VTUpaXKxqyw7z5c5+cecbJFnnXUt9dyG097kBRA=;
        b=jp51xFQtFLKcrYVfoLOejT5oUazpBjx+EwbIYrYqdqmMXDKmFSoOOB2WXcfxD63h+F
         etSplpJUlkTQOSZdOC36/oMrVBqXK12t4YQHNDbCZ2jdzDstfPOexfDiIL+uRZo/JYUv
         YIaHqm5SdF5WgPZji/KWwE9ldjIj1V8qvBraSiSn69Fk4WI1LPyhVtcNr0IjOrjlvhPR
         Jeou3hou9LsimA4PN8HHZLnOIq8cspauzGeGpk+RpZe9E06nvRbxp70h6x8Gx3djAsxB
         0eIm8Ioe665AO8QwRnj06waEi3GmdZ2xjgLaRdi6mYaNT5z/H4GTvTOXQf9Om9KUr/hi
         K2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vuf6VTUpaXKxqyw7z5c5+cecbJFnnXUt9dyG097kBRA=;
        b=rOWroAcWW3nhxK4A+6gkJNq8UPWVMkz1TeB8y85kHUOXSoH56+zDM7ghV718c2O1hN
         3HsvzFL7LzzdSc4Eb9I/tDzq9PxUCSi2Pj2cEMIuoUqPVTcehQsuhXraqtPDQiJRjTtN
         PDLRsV6A8V95SMf7XKMnmqrLQ1DQkbO7upfFHsQqn1ZIFHo2DeNxOLxG2hucjSTBlc4T
         yTs74QYap6PovqwmmvBY5Ffe+7E8xdBMB1NdKK24zd5KdyQIoMXm2WcJOZlNG+FlCeKH
         iPXdRfeaXvS2saloYCb0zd44M6U29Bxyh4ftS9WOZ3G4QvoZL65+ec9lhhri/MqbJlHG
         H95w==
X-Gm-Message-State: AO0yUKVw3MXcA50+FmngMTxs/xe4Aao0v9s2eaPRwzzyFxOZmMYXbj9l
        cZ1T3MYzjLdqpqwcLhFsmrG8Vi7F9dE=
X-Google-Smtp-Source: AK7set/t8n+5AoxPx92KpJTLhDs3oOya92cDC79HKsUoAfWqru9C1l/loor7GL54hY8lsU9m52yLaw==
X-Received: by 2002:a05:6a20:ce45:b0:b9:2df:7ef6 with SMTP id id5-20020a056a20ce4500b000b902df7ef6mr16369316pzb.31.1675054134322;
        Sun, 29 Jan 2023 20:48:54 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:6882:174b:bc70:101])
        by smtp.gmail.com with ESMTPSA id q5-20020a170902bd8500b00194caf3ccc4sm6631099pls.285.2023.01.29.20.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 20:48:53 -0800 (PST)
Date:   Sun, 29 Jan 2023 20:48:50 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH] Input: edt-ft5x06 - fix typo in a comment
Message-ID: <Y9dMMnD/I1u4mAiy@google.com>
References: <20230128162325.64467-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230128162325.64467-1-dario.binacchi@amarulasolutions.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2023 at 05:23:25PM +0100, Dario Binacchi wrote:
> Replace 'firmares' with 'firmwares'.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

Applied, thank you.

-- 
Dmitry
