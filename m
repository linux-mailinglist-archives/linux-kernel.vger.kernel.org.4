Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDDB26E396D
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 16:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbjDPOl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 10:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjDPOl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 10:41:57 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA031E0;
        Sun, 16 Apr 2023 07:41:56 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-329560b1994so4671775ab.3;
        Sun, 16 Apr 2023 07:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681656116; x=1684248116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NmJ4IqjBl3Jk6w/fopB23i77kC90IHeBCJ+VI0whPpE=;
        b=NgJl0IF7YQwB7U0YpKeykBUtKzI0+N9aHjX8dbModV5fijLHl7fJ6IhmIks7/CQYET
         2LkAm6amlpsVj250T9A+dQfpcC43HCQLTpX9x4nW5NDVO5W/X6Q3h3B+2sVQAKLTeELm
         l5q5v7EZNRJUk3DsOQl40edQvs2JSGWp6SuMQ7p0lt04VNp3u+WxEv6lGl1icRmeNWdK
         bETtT1d7OcahC+suPxEZkh/ZNZamI6dTubACo/LAWNwNU+OS1RJmKJjBydirLPH8Omjg
         0ExHayuEkmCFG59YkrZ2Z2wc7xEUhlDnkobu8vNj2ZshiPwN31b9j0uYmuJytcSY8JBp
         23QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681656116; x=1684248116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NmJ4IqjBl3Jk6w/fopB23i77kC90IHeBCJ+VI0whPpE=;
        b=h8QUoDKGRuxEboM7OEyc8NxVP1vAk/jMI6VG4xpqML6l9I6xLKJ5p0GfyI6b/kVwcN
         CL18UL+T4PEsZl3UXrOi0wgczgDHbk48yAvZB3eFCBrrf6x2Af+su4sqGxRXAfKzX0Ox
         qRRgEWM9jxlQJhH6fZP2tIhb+rYIrGQhD0+pSNG7iCNIPDRh0hAIujkfQcaO7RvfGgZS
         XjoooESplHNRwq8qPW4v+vjEBJNoUmd3Mz5aIhblCXH7OCf+kI4LIRsQ9StdwK+3o6es
         /Wm2/i67pdO9FmJJ5Vq3VsD72KdfWEchq2MDL8N2Mc1YCmDPAFlzmQ5wZP26vrpaUKsR
         MgDg==
X-Gm-Message-State: AAQBX9eSHFkVUqkeVvYTHFh5ezWagrdGqf2SxGSiiBHMzilqWDkH6BlY
        pvM2A1kJd9jqGkAcjMHGyWA=
X-Google-Smtp-Source: AKy350adGYsjNKlzUDHlcQtnRav7KGpTFKdeyWKIi5lL7OxgxeaIVGGsDhl/KZP36BAmzK/hPIEa/A==
X-Received: by 2002:a92:d4c2:0:b0:328:c67f:509d with SMTP id o2-20020a92d4c2000000b00328c67f509dmr7611854ilm.20.1681656115916;
        Sun, 16 Apr 2023 07:41:55 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r18-20020a056e02109200b0032a8e1ba829sm2153629ilj.16.2023.04.16.07.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 07:41:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 16 Apr 2023 07:41:54 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Lakshmi Yadlapati <lakshmiy@us.ibm.com>
Cc:     robh+dt@kernel.org, jdelvare@suse.com,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        eajames@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v7 2/5] dt-bindings: trivial-devices: Add acbel,fsg032
Message-ID: <9edf6d91-96c9-4043-b55b-08e402eca5fa@roeck-us.net>
References: <20230413132627.3444119-1-lakshmiy@us.ibm.com>
 <20230413132627.3444119-3-lakshmiy@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413132627.3444119-3-lakshmiy@us.ibm.com>
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

On Thu, Apr 13, 2023 at 08:26:24AM -0500, Lakshmi Yadlapati wrote:
> Add new Acbel FSG032 power supply to trivial devices.
> 
> Signed-off-by: Lakshmi Yadlapati <lakshmiy@us.ibm.com>
> Acked-by: Rob Herring <robh@kernel.org>

Applied.

Thanks,
Guenter
