Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A8D6DF99F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 17:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjDLPSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 11:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjDLPSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 11:18:44 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB36F19A4;
        Wed, 12 Apr 2023 08:18:18 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id q15-20020a17090a2dcf00b0023efab0e3bfso14889039pjm.3;
        Wed, 12 Apr 2023 08:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681312698; x=1683904698;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PBdAiudwsZrxAWgz03gjkUeI/ey0GGb580RTaoqKdnY=;
        b=JQRoSmAcsAbmBQXtit40Ic4wplBUDKdYCOJDIvRtkMKSung4cSLcK1RVxuAYCAicRX
         Anx15scGVA1uPgrmkuel5HSlsLWvW7ddc7zDyWr/vOM/4CJLxrJSZolnUZwak2U30mxp
         02qqDcieYWLBUxBUmhAGWRnL2cqSX14+PoyWfhsH+1FhxS8zqkq9EVt2jCtKm/i3sQQB
         bV7ysRh89vTMsdYz2gPjKnwBc3tQxHOgO9WajJVfG/5Uy0/hRvjWqiMmKGibC+TqstDl
         PUkObe6MlqIYnqR9xLH2kayljqGOQg5Fawvfh7GyRovkVfbSyC6ZU+ys+AM8BxadnWu8
         uPfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681312698; x=1683904698;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PBdAiudwsZrxAWgz03gjkUeI/ey0GGb580RTaoqKdnY=;
        b=mRQFC+s9jbalGPnc662DnUkRmduDajuQP+3yHMtbAJ3nMdtz5HXe0VOADdhO/BoRMs
         wOcuoFQ89pB9bTvK8D1xbfTkUQ1nm+yVozkqM7TCCHk9jso4qYBlNGEaP3PDmQVGQVuu
         vCq8RtadrKIeqZCXk0jc52dBjo2gXcPucJrVVc8+TztqI/ANzt/dx8vGRcDCU2G+7QRY
         nRF2/tirjvcUCR6xyUHJV5oFpnUaQWk1LgrrwC4z/1ZezKPPzZrdopCkQSTJgfGmUhec
         utvRWDswGcmrjF7cjvfM/IfWdWVKjouZ3iaZ2ET3mbFaGktvVXYKo6TUbZ7uqH04Uv1w
         ss6w==
X-Gm-Message-State: AAQBX9eyaZEowc6FBSM2GzfYbF8OFmd3HoqpLvSi4yloq/l4yYuVedlt
        m3rkITvzWrBa3MQ6dicKgAk=
X-Google-Smtp-Source: AKy350bOI1Wh66KAElENSsK5tXKePFCqIGw4hT1jsfypUkHnaIjN26j+9Ck/Bk3S0MzFGtXwqxa7Ag==
X-Received: by 2002:a17:902:f54b:b0:1a4:f79d:67bc with SMTP id h11-20020a170902f54b00b001a4f79d67bcmr9634257plf.43.1681312698458;
        Wed, 12 Apr 2023 08:18:18 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k9-20020a170902694900b001a5000ba26esm11518466plt.264.2023.04.12.08.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 08:18:18 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 12 Apr 2023 08:18:17 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: ina2xx: add supply property
Message-ID: <970b8923-010a-481b-8521-68272b5c0e16@roeck-us.net>
References: <20230407160508.20479-1-clamor95@gmail.com>
 <20230407160508.20479-2-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230407160508.20479-2-clamor95@gmail.com>
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

On Fri, Apr 07, 2023 at 07:05:07PM +0300, Svyatoslav Ryhel wrote:
> Add vs-supply property.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Acked-by: Rob Herring <robh@kernel.org>

Applied to hwmon-next.

Thanks,
Guenter
