Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64DE26E3970
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 16:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjDPOmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 10:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjDPOmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 10:42:14 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A625FE0;
        Sun, 16 Apr 2023 07:42:11 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-7606d44dbb5so161030139f.1;
        Sun, 16 Apr 2023 07:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681656131; x=1684248131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VRjMiCpc8gHILthGX+ACf7Db4BcNRu4gzGOqKXlsEzI=;
        b=dNQiVmtOwXQ5SAN0Upp5ci3wjblyMEq2BEFaRUd3g/ymfvezeQu4wbwLKjICmN/we4
         AKpznzronGgZfDdRwVeH6masUlOCJRrS10/DiR6Yd8UIIZcMiy3jC4A5rU7mNVFGtD+3
         nW2PbFZoWfKybndbcbp/4BObzv9imP+L/H2WS0tbLcGUsn3AANVRbF+DRZ9NMzEW6PG+
         wdcdJbA6iu3kzNbPaH0C/DfakMh8YQxN35jZaSDkIGU4Ee+pEUy8eGh3hdtr07si5zTh
         foatXcOmH/9eW2/SKnWRrE7XtoC3n7LUYjIoeDfO1dWVfnfdVUWRvpW5SbM94fcGU7QW
         hLmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681656131; x=1684248131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VRjMiCpc8gHILthGX+ACf7Db4BcNRu4gzGOqKXlsEzI=;
        b=cKPw9W0BXW2lTKdB8ZeSmE8ZCp0Cah+BvE9tWG7N1a2R6RMsbPEfRNa8gzehsBo34R
         YEJjcWNeb91s7EwOnTkpgE91R9xfuw19m9gSRMIeAGUQTJjzScKtBQ6n+JHtB82rZgkd
         YUCgC2V6EbRUK+AfYfbuQ67DPURijs0J+oUJ3l+EcwmCdvCT9xzBABhl2Yz0hfIyc8xp
         G3PgUQuxKx4izJQAzMWX06tsr2ov3KRzUJaoa4NnYm1A8pxMkBX4fWbPtSMtUiBvPDzK
         v3fVjXSz7odSyICcr5wGii2l1lK6dwASU4sBvaMa/4na/RS+e5op6D7vzQLP8u4bY1wq
         VhJQ==
X-Gm-Message-State: AAQBX9eiz+DS3w5wr3nPK/WAV2cCnXXX3qBTjby7U7R2aYrBXZaOOffF
        TaXEtg4BpAaOKA9WR6kOIpc=
X-Google-Smtp-Source: AKy350YvEIKOgPwl8QuHzZ1Ulw5/1UqKOm2S6ijXk/CkltsyIv1+GwHD4lQUt9f6tMvqoSWwRYUxig==
X-Received: by 2002:a92:d710:0:b0:326:68bc:b420 with SMTP id m16-20020a92d710000000b0032668bcb420mr7751076iln.15.1681656131118;
        Sun, 16 Apr 2023 07:42:11 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d17-20020a023f11000000b0040f94ea2a2bsm1075403jaa.40.2023.04.16.07.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 07:42:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 16 Apr 2023 07:42:09 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Lakshmi Yadlapati <lakshmiy@us.ibm.com>
Cc:     robh+dt@kernel.org, jdelvare@suse.com,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        eajames@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 3/5] hwmon: (pmbus/acbel-fsg032) Add Acbel power supply
Message-ID: <23f1dc3b-be37-4eb2-817a-f1d1c510ae93@roeck-us.net>
References: <20230413132627.3444119-1-lakshmiy@us.ibm.com>
 <20230413132627.3444119-4-lakshmiy@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413132627.3444119-4-lakshmiy@us.ibm.com>
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

On Thu, Apr 13, 2023 at 08:26:25AM -0500, Lakshmi Yadlapati wrote:
> Add the driver to support ACBEL FSG032 power supply.
> 
> Signed-off-by: Lakshmi Yadlapati <lakshmiy@us.ibm.com>

Applied.

Thanks,
Guenter
