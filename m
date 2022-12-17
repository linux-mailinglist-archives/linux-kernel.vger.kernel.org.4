Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E591A64FC5B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 22:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiLQVBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 16:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiLQVA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 16:00:57 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D30E004
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 13:00:55 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id k22-20020a05600c1c9600b003d1ee3a6289so3986248wms.2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 13:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xBAuq5jrs/F0QNXmgSnKGyr8XPJNiWKZyq9E0iSuiwE=;
        b=w7E5X5CV2Xdn0phpyu7k9zI7JQxxrT+Zsv8L0QRqJS6jUwqVNyMN6mvXnTstS053vB
         09GUzA0JIYGncJGIt9FjCmvoSDiaWJjbjfW2i/9QmyivKVU8FFfCZstMwpODutoHZI/S
         miZ4bnemzCDSEiDIsZ5ffM58rJ+9MhUCbAT0PQ1of8p00tDnkw7un6ko/nL0oryrhz7Q
         WyXwNTBJL7YKJnncnHpp9YlkDVvgdJ6+ugBxcRskAZzFcU2pNQcbR9pCn+yhaKJOvlLN
         t0c2Fj1mjVfmqOpXTkwq/9raazHECIw14KeoEC40Jhx7YBS2LO0tDckgpF8k9Jh9BJKt
         Bk2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xBAuq5jrs/F0QNXmgSnKGyr8XPJNiWKZyq9E0iSuiwE=;
        b=KqzmmIE/a68sXPlWSAgcTFJqfxo1zmvhnZFHsdO6VrtNvJBfnb8c1coUjlT2fjuMdH
         MxP5J2Thq/aHvMoHNNtewDdUK3kojTaARRAm4M6Dtyu4gOmHJH8Y5D5Pzqu0Yeb1mZyj
         9klFKGg+wAgvtK91PT7Eu3+CydeeH1qE4nQLii8t3GoFfQKGgTFmak5bEYVwChXkg3Sw
         U+CiV67PPZmkgEXD6bGEYrjlQWvV47PY5nXPfGOAoi76KIJ4QqeL62Nx2AOT4f3MSC6Y
         R8ZfpOjWKz3JceopaHd3JMQldzFYeiUuLJ9U/IRv2GGTkXURb+VGUliy23b+J46ujuD6
         7jXg==
X-Gm-Message-State: ANoB5pmtFVa23EBgjfysidJDEU5sImBBl1P5IqUXMEr/XxgiIxfi4c0B
        X8ZRBqHOKeHYiFxqKJbtDkBPcg==
X-Google-Smtp-Source: AA0mqf50Ip+1PsW79F2vF0geQ0dfNWFjlqKaTX4jZOpZap09W2NdEM74Sdvgm/MqkxEMF3nfddQb+w==
X-Received: by 2002:a1c:4b14:0:b0:3d2:39dc:4ab9 with SMTP id y20-20020a1c4b14000000b003d239dc4ab9mr11781779wma.13.1671310854181;
        Sat, 17 Dec 2022 13:00:54 -0800 (PST)
Received: from Red ([2a01:cb1d:3d5:a100:4a02:2aff:fe07:1efc])
        by smtp.googlemail.com with ESMTPSA id o3-20020a05600c510300b003cfa3a12660sm25187618wms.1.2022.12.17.13.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Dec 2022 13:00:53 -0800 (PST)
Date:   Sat, 17 Dec 2022 22:00:50 +0100
From:   Corentin LABBE <clabbe@baylibre.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: hwmon: gpio-fan: convert to YAML
Message-ID: <Y54uAuwrwU5Nl8kp@Red>
References: <20220126200350.3633576-1-clabbe@baylibre.com>
 <Y54BbjoRm5z2Tlp8@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y54BbjoRm5z2Tlp8@spud>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Sat, Dec 17, 2022 at 05:50:38PM +0000, Conor Dooley a écrit :
> On Wed, Jan 26, 2022 at 08:03:50PM +0000, Corentin Labbe wrote:
> > Converts hwmon/gpio-fan.txt to YAML
> > 
> > Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> > ---
> > 
> > I didnt found any clear maintainer and since DT yaml mandates a
> > maintainer section, I set devicetree@vger.kernel.org.
> 
> Hey Corentin,
> Looks like there were only some minor comments from Rob on this patch,
> but I do not see a v2 on lore. Just never get around to sending a v2, or
> did it fall through the cracks?
> Thanks,
> Conor.
> 

I just forgot it.

I will send v2 soon.

Thanks for the reminder
Regards
