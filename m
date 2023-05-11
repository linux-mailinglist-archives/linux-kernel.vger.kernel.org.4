Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5DE6FF986
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 20:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238915AbjEKShk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 14:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239059AbjEKShQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 14:37:16 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A687735A5;
        Thu, 11 May 2023 11:37:15 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1ab14cb3aaeso64077005ad.2;
        Thu, 11 May 2023 11:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683830235; x=1686422235;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mo08lR/lndoev9zDyfO8bS5MbMffpTCzQ0BQI7W4HeU=;
        b=ZjufzySMFT0IpCJ6hm1J5F0bwBF0SS1P2pZFAkgBRsJlugPRD6HS3z98JKFKriKQvN
         I+tTybvdohQu/ozmMbzRQwOFNSLvti+M84qRnRO7p4wpJMIeoQ3ckzTZj2EVyj5N1gU3
         UueF3ecP1mthhXDYlywKGUgvCdNOywp8UwQg6NqBkl+Fm01bs0lk/nm3M3W1kmlbQtyj
         zfzDAFDaWL1ncb2z6NJfHqrVATquCbPovH3qM3WGRbRpifGrI05zYcb7NDDbn4K+mde2
         R7D+hT+BAgWQHphdMFc0sqRC2/aWXhZ6rNQDdHILJ7Wvlxxo0dbCZHlQoQatGBBchkNp
         mS0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683830235; x=1686422235;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mo08lR/lndoev9zDyfO8bS5MbMffpTCzQ0BQI7W4HeU=;
        b=kxJu11GOcRnHWXxvwW3VrViGWgRw2t5US3Z7yiySv/OV2vZY2iBh/rs/1CZxzvRdYy
         ONVQTTv9/EMQiu1B3TTkqJx9+S/3c2uG5c1NHJexuamI3KIGbAf29hV+b/8h7Oz72PMV
         IqKsQBb9xriF87aE+HK0rKjAXXCD2DJ7LJapmUCMBrg8eIZlpU7en5ZeBylMwUcAWLm3
         kUE5v/DrPmjuyMDLVuiA5ggnAwsExJinHGk4bFYxELAgeGvYhpb5YqnNz4O4ZFZBSI0A
         pb+Pw2GG10qzAkPmqMfHQuRVJFDOliKDSpnAlD24irtvmsWiKCrmcowzM+Qd4ho40YM8
         LO5Q==
X-Gm-Message-State: AC+VfDySssxoycJ5ShvCGM4i8vx6xhA35Sr9EFjZkw7JyerHsYOHH7kR
        cLjCKJiiP8XlpuKdNRN45Rw=
X-Google-Smtp-Source: ACHHUZ6y9IQWE9dUS3itkOFqCtNsapKpGul15zAsgOE4bbPy/cpxYsOfeABeBdbyYqd9ZoS1EgdBEQ==
X-Received: by 2002:a17:902:aa8d:b0:1a6:db0a:8003 with SMTP id d13-20020a170902aa8d00b001a6db0a8003mr22022175plr.23.1683830234878;
        Thu, 11 May 2023 11:37:14 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:84a:ed9c:4024:c347])
        by smtp.gmail.com with ESMTPSA id b13-20020a170902b60d00b001aafdf8063dsm6264348pls.157.2023.05.11.11.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 11:37:13 -0700 (PDT)
Date:   Thu, 11 May 2023 11:37:10 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [RESEND PATCH] dt-bindings: input: cypress,cyapa: convert to
 dtschema
Message-ID: <ZF011h0Ho0qUI/U8@google.com>
References: <20230511102559.175088-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511102559.175088-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 12:25:59PM +0200, Krzysztof Kozlowski wrote:
> Convert the Cypress All Points Addressable (APA) I2C Touchpad / Trackpad
> bindings to DT schema.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied, thank you.

-- 
Dmitry
