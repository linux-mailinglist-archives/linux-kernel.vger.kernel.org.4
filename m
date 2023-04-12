Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2576DF999
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 17:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjDLPRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 11:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjDLPRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 11:17:44 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1227ABB;
        Wed, 12 Apr 2023 08:17:35 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id p8so11793421plk.9;
        Wed, 12 Apr 2023 08:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681312655; x=1683904655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lXF0M8ANb/S1+Ov1PDbB2m5VawQaqhAZf2fWUn9CoWA=;
        b=hsuFVrxxQ6xiG07eLMH08j6NecdqR/0cfvRQl67MPuAhj4+Dvlqzw2gYdWuj33s0DK
         ot2595G2+QNgi9c2sX/2tO3oEhwbmg+uQewBragkuiC+/Lxbkx4DzYFoQZit1xfsy6kN
         E+VrsQTwusG8xpOtJCIfQSbkfUOIElZ+8omWH7+waQ0HZ7Vg2nFCjH5SweekQjsV/qHC
         SsBy9zoYC0pKbIQkezJOKjYUJ0jjF8NymqCjzXYyolE4G23orKDH8hv+QsRq/Bb47nCk
         NfKuaHJMBIrJvCny1ExYgWbkwof4c+b4ytdHgjLRBGcracw4CLMLsfxLNcbtAaBNbI2J
         ZXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681312655; x=1683904655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lXF0M8ANb/S1+Ov1PDbB2m5VawQaqhAZf2fWUn9CoWA=;
        b=eRRugrzwfRp1xEFzys/D7I1XLPMdfy28szixZ/nXo8IDGUU9wYdkPfPyUUbQ/j9b6a
         RNdTgz1oFsB+gWPbuDCJH9t0D5u5jQxeute03OA0mD/wZWCvmz3wK4k0q/WEQliJxhzR
         bq+cNToR4bGdqakB4yVZrDp0q7dxhTNfchx2mK52rIDfvtg4DLAQI8EL1g9LUr/FEBFo
         txJSJVq+rvrs7FV66+IPXIWrBl8RQ6+dZs0StJnTp3If1+bh27yLA9ZjwmlhtfnfqXX/
         chLxcb06ajRlbwdmEdqzcKA/LiKbu3TvQdZtfEYiL2oq0TZ9+7x0QTXThN6nJoKLWD0j
         VLqg==
X-Gm-Message-State: AAQBX9e2fV5EqKQNn9p67gRinkpRJm2dFqT1BH3jcIMQttCrV8jlXubH
        m562ZCulhBEXXdp5ROYTsnNO/q8BxDg=
X-Google-Smtp-Source: AKy350aodtH/90OqVyY8JXbpvT8JGcsKs6dqZXseHtJMWkNDpxI6xnlmD57rGgpA1CEM8T1G8sRidg==
X-Received: by 2002:a17:903:124f:b0:1a5:5e7:a1c9 with SMTP id u15-20020a170903124f00b001a505e7a1c9mr9370822plh.61.1681312655059;
        Wed, 12 Apr 2023 08:17:35 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902d38c00b001a64fb9cf54sm4124118pld.44.2023.04.12.08.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 08:17:34 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 12 Apr 2023 08:17:33 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v3 1/1] dt-bindings: hwmon: pwm-fan: Convert to DT schema
Message-ID: <6bd199d3-a551-4e74-bc38-3ea0558a40d6@roeck-us.net>
References: <20230406182000.956275-1-cristian.ciocaltea@collabora.com>
 <20230406182000.956275-2-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406182000.956275-2-cristian.ciocaltea@collabora.com>
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

On Thu, Apr 06, 2023 at 09:20:00PM +0300, Cristian Ciocaltea wrote:
> Convert the PWM fan bindings to DT schema format.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to hwmon-next.

Thanks,
Guenter
