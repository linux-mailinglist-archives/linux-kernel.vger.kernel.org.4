Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F517714DE1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 18:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjE2QIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 12:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjE2QI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 12:08:29 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B393C4;
        Mon, 29 May 2023 09:08:28 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-64d1e96c082so2552018b3a.1;
        Mon, 29 May 2023 09:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685376507; x=1687968507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4UVveSYzDTWhwSyyrBcs79PsC8SmlARfyMO3lrHSj+I=;
        b=QmVHqBfVe/YYXKX9S+/X3MaE5zKAgsSlp0/ALSA/3T4vEKmHNe3JWopGdJdDpgSAFc
         GpMtEDV40iibROAPTJJ4TGb1AeZXZIMCsQrGwnszxyzjYpcaAsRJhGFlhGaAe+0PjdBz
         6E1Yh7LV+LaU5BgS01yel6RZiwGxkh4l0EkVcLOTRY4ODr0dCI+Bo9A1EqtKHYDvOcfg
         6NsMD83UYNQNxaFhGwr6umWR6h0AXuOUXQ8i4VID1zsc7XSBrv2WSGCuLAoDGF3rtbdE
         mTzunejfAeESMVUd7GeInclVdpAFqKP9oZmq3hPXLAUX1olEFFEQ9ud5lZH0ONerZhBP
         eRRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685376507; x=1687968507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4UVveSYzDTWhwSyyrBcs79PsC8SmlARfyMO3lrHSj+I=;
        b=dTpVXtabaN0ryjy4PTwKiYBCzT4RJ5e/bCNA5ggRNnXG1gg2i1jSyRoTkhq+MTUlzL
         SE4Y/FI/qeQl7hLakIZqWR2z28JHXm45l4Ae46c1gK3BA668tIU+NHFETL7eHO9uZmyu
         /e4lhvnJgEHKR4dX9CiGIvC8fhar6sFVz56f1znhwe7uoTSt07JU+ImzoqoionhTbYPO
         C9CtKrlyxn65ycEMoYEgIqjv9aGX5ayYbFXE71kox7pTkE6RnMebAevpY55mFyBQpOGb
         JwSuldx2YElGlihyMJYcGKV02DEY8/Y1Ggiw2qPCQX/18gdhL4si75MLlgHZV4/2dnXn
         V7wQ==
X-Gm-Message-State: AC+VfDz3+lUM9Zer2iujjKX6GHqAlKO80AgnwDAPtHXaAn50W9eNYDmP
        ujmk5w4mtto8CEqShuWMDSk=
X-Google-Smtp-Source: ACHHUZ5eAgNv1Y6bvPQ2TRJHwxASZWTlnGd4yXpKfz7O5OnEt2l2IUHGaIIRPKboWLx1YkRofhJESg==
X-Received: by 2002:a05:6a20:1585:b0:ff:a017:2b07 with SMTP id h5-20020a056a20158500b000ffa0172b07mr10313172pzj.20.1685376507557;
        Mon, 29 May 2023 09:08:27 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p9-20020a17090a74c900b0025063e893c9sm1597270pjl.55.2023.05.29.09.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 09:08:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 29 May 2023 09:08:26 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.3 000/127] 6.3.5-rc1 review
Message-ID: <606c6527-d70a-430b-8f30-3ffd4b8def05@roeck-us.net>
References: <20230528190836.161231414@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230528190836.161231414@linuxfoundation.org>
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

On Sun, May 28, 2023 at 08:09:36PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.5 release.
> There are 127 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 30 May 2023 19:08:13 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 153 pass: 153 fail: 0
Qemu test results:
	total: 520 pass: 520 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
