Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F11674DD8E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 20:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbjGJSrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 14:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232830AbjGJSrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 14:47:09 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33DADA;
        Mon, 10 Jul 2023 11:47:08 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-bff27026cb0so5915492276.1;
        Mon, 10 Jul 2023 11:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689014828; x=1691606828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l+e9Uwr5qc+lETVgqhuxS2sDSgDIyaCoLKWXGQhfhM8=;
        b=EWRHAx0bvPOAglJM0S8gK5Hv9aoMSGq2QqlxfcB8wusYDCJ5OBepPkmptt3/XfyNRC
         SQmiL0wVcnkGLiyHC0ifgymkojTs1kSq9m3OWxDD42HD6cRmjlQszYW3G4wVwOiISE1p
         bZYywsQlZDnE6pFMDRL2x0u6pnBlkU+zRSiABvT4qUwUlQgb86/8iabqtisNH2uM0KWX
         iaQVpfAofBzrghuBYpS2gCDApI/4hMVH4fZdmpusUZ3DEYBCTAjuTLWmq5kWnygg0Bz8
         Mehibba4+SYuc6g3H5sNOhx49fDI2IsLRwOrLTVLu4JG4LHvK5yKR30RX2xbCZddrrDp
         jK5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689014828; x=1691606828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l+e9Uwr5qc+lETVgqhuxS2sDSgDIyaCoLKWXGQhfhM8=;
        b=N8YSTmDIl4S/6wPvNuQwd2y54VRUsFPdDeZaed2Vcyvl5nSrwU/cYo9uahocUAqEJO
         U6GcUnOFCQL/m9qWRQSFZs9pQnXNLJonI+pirPaJPQf5LD5SVqXXpWBQwX5Yw0qTpLRj
         e0zdLbEZSkkpXUch/dYLKy8tfVVr3ANe0wi36ZJ4yBtk8/B8bJh/DuLEzb19JHhSAf2l
         a1yT4Cyyhnr+6+lmebxAJBDRaxyE95gqSI7x/2g9AnIUWkjGgBauDJZvnmpVt49M403n
         HSNXzgZ4BnVBE56V+cKWzXLwAOVv6NfP1swxZ5Opb3IbA3wk2f+89JPaSZF9hEEC8u9k
         X2YA==
X-Gm-Message-State: ABy/qLanepouOf3FEyX01HYs0thYs9ZLkvbFRn/fkGIrftXpFX5LJ+6M
        q3uOUFW68zT224NdyMylIXk=
X-Google-Smtp-Source: APBJJlE41i05qAHdgQLCqK7cflEjRGKFjOomlZ9w+N0fqyZicN3jiKw6stBSCJdKy8ilqTwlPRgvzQ==
X-Received: by 2002:a25:a409:0:b0:c81:ea4:c660 with SMTP id f9-20020a25a409000000b00c810ea4c660mr4849770ybi.8.1689014827889;
        Mon, 10 Jul 2023 11:47:07 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y18-20020a259292000000b00be45a29d440sm86689ybl.12.2023.07.10.11.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 11:47:07 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 10 Jul 2023 11:47:05 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.4 0/6] 6.4.3-rc2 review
Message-ID: <720d1a58-9f0b-4647-8cf7-047f830f68be@roeck-us.net>
References: <20230709203826.141774942@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230709203826.141774942@linuxfoundation.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 09, 2023 at 10:45:16PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.3 release.
> There are 6 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 11 Jul 2023 20:38:10 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 157 pass: 157 fail: 0
Qemu test results:
	total: 520 pass: 520 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
