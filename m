Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182D56DF9AF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 17:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjDLPTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 11:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjDLPTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 11:19:07 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74CB583E3;
        Wed, 12 Apr 2023 08:19:03 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id jx2-20020a17090b46c200b002469a9ff94aso10078581pjb.3;
        Wed, 12 Apr 2023 08:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681312742; x=1683904742;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+2uEexTBVRZa3m3nKBZg8SoJYvibuE4T6Sm0J0Zmz/4=;
        b=GtgJc70tuhxfY6Iq69Qx5XbtXg3N7GiuOyduExG4QpqQzeX4XJG4tMiaq1EgdGGyjB
         r9Uf67Z3OggUH2pYakOtXrRwgemvOt3pzNR9quE1Hz/qu00LhJsaurlZHlnO68sqPxNn
         0ZcMY1A+yvEtUbHAVCWOeO+KiVVI+E1EuIgl89yUeXcxKxSnoZbGNf8RVPfkDEEjpIs1
         RjU0TJ9K2OGQKp8xXqRDEwcxRjgFmX12GyXB1v0EIhrK550fbdntUNYHdxr8wHYgB8LD
         a94vKt42z+IkOUWf5HLX6uD1Ltz/p8zof+gVlGpYkQag8+wU4/QAnkLGt9qpCkiOxeDK
         qarg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681312742; x=1683904742;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+2uEexTBVRZa3m3nKBZg8SoJYvibuE4T6Sm0J0Zmz/4=;
        b=GZd1SaGQyAtd2GSHT9fOvZ+2ahcp96b8wDwa/NpAR2QtJu37A53lNeoWpVGA3QTYWs
         M9/P845Oaj3wwssSRIHLVi/9/J3OJEXqjAp22cLWBW0z1b8Zi9GXXJjcm0Oy4/ncmm6q
         NyFWUF/VrFAqc9JP6J4c4Q9v1nf7V8cvZHMheEB2Q7nJ6QIcDOKrZWWJbQJscMEa0/P2
         zKRbqPM7vIh8QoHYkgagk+qc/eXVgBaIE5o0DNJpJ7A0yTPTx/+IEhUN/BjNcCFwbxr9
         jtS6HnSR5p+DVf3meaYiCIlSlS7+kNVyTPlaCM53sVszRXpMYsHB92ynARS6qydaKll3
         Agjg==
X-Gm-Message-State: AAQBX9cx4bgFIQbv1/UHnZxiAojeSCauatoZ6LWP73J9/l0WTi7HxfYq
        n7Ez67+HbeE0YwgVtju1X5k=
X-Google-Smtp-Source: AKy350Y/cAsq7tIBM3ZSlea9IswD9rCLn+XF9Q5SKxjh2uQrhQ2piMIV/gQTN7fij8C7Je3zQXlxYQ==
X-Received: by 2002:a17:902:f545:b0:1a6:3d40:d74b with SMTP id h5-20020a170902f54500b001a63d40d74bmr3898611plf.16.1681312742594;
        Wed, 12 Apr 2023 08:19:02 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id jk1-20020a170903330100b0019ea9e5815bsm11780656plb.45.2023.04.12.08.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 08:19:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 12 Apr 2023 08:19:01 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] hwmon: ina2xx: add optional regulator support
Message-ID: <069eb0de-437a-4622-ac6d-9cfa52297e9d@roeck-us.net>
References: <20230407160508.20479-1-clamor95@gmail.com>
 <20230407160508.20479-3-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230407160508.20479-3-clamor95@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2023 at 07:05:08PM +0300, Svyatoslav Ryhel wrote:
> TI ina2xx sensors according to datasheets have dedicated
> vs supplies. Add it for proper work.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>

Applied to hwmon-next.

Thanks,
Guenter
