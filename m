Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06516F0EFF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 01:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344510AbjD0Xb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 19:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344444AbjD0XbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 19:31:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6194B2D55
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 16:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682638217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EVstEm9h+f8vy/mEV9sr+uXiJuKtGJYBIssk81uyPSQ=;
        b=OIHTp/UyyZBqmXSjR3cLk3i+hamcv44jyxX5XUFSrVVF5uyGw38Kdbz5grrgtiu1PqbKP5
        ZVgte9bBzxGu6YFIPsjehXaoFwfdb0/yPnWT1DfG+eeDsB5fzlmDsgGTulg34JyynA8sXY
        iHcy1drSB1m/y3x481ohpWgW7rmPkDY=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-tRRrdIqVN5WyV1xZ3wPoyw-1; Thu, 27 Apr 2023 19:30:16 -0400
X-MC-Unique: tRRrdIqVN5WyV1xZ3wPoyw-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-54f8a3f6b03so142921617b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 16:30:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682638215; x=1685230215;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EVstEm9h+f8vy/mEV9sr+uXiJuKtGJYBIssk81uyPSQ=;
        b=NNABUL0siq7HY7H7aeGKy77yYOyZIki+81UIUYhjU4GU9hS6KlgCPbV7lpyUqjB44d
         iBoAG8tzqaZDw/fRhk/FsgN193kyVN6iypc4CLT91ILb71rbyCclFHCltG/4HJtCJ64V
         9YQzoRoZF/FaI3HGRw5G4YFW9/aMttC3p5p3322wur5EjwA1RjGyoCUIrAfVDL7+CxeQ
         GfbcEDLY6kG/+UoDd7JAYlbAzyRh1qrLtx9nFmpgxMmZVdwJgYifa69AACZUVsej7Wjl
         UgS/SD1DlqGB47VVyjsTI5+fbslttvfsgoxanhE9o0YCpHYEOcrczITJDFKQORnv/HN0
         xngQ==
X-Gm-Message-State: AC+VfDzTThzg0sdvYDNnE3By+OOnvHymvt4fRMg1001QOn068V9+5emj
        v5APUndozlxbpzwVS2T0eQhbeQteLddSvpY/KoYsjiWHExPXp+TUd/tsc15+p78btatI0wGq0hm
        yQ9IH7mmet4QckSDs4c++yfcG
X-Received: by 2002:a0d:d8cf:0:b0:544:5b63:b956 with SMTP id a198-20020a0dd8cf000000b005445b63b956mr2652652ywe.8.1682638215739;
        Thu, 27 Apr 2023 16:30:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4AlF6UPNRzq0q97LZdRYbg5r+sonNynDI2yOTx2L/mRwUr5sNyCxdgQv79FQ8u/uf/zku5iQ==
X-Received: by 2002:a0d:d8cf:0:b0:544:5b63:b956 with SMTP id a198-20020a0dd8cf000000b005445b63b956mr2652642ywe.8.1682638215497;
        Thu, 27 Apr 2023 16:30:15 -0700 (PDT)
Received: from x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id k187-20020a816fc4000000b00545a08184b9sm5113278ywc.73.2023.04.27.16.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 16:30:14 -0700 (PDT)
Date:   Thu, 27 Apr 2023 19:30:12 -0400
From:   Brian Masney <bmasney@redhat.com>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Brian Masney <masneyb@onstation.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/4] Input: pwm-vibra - add newline to dev_err prints
Message-ID: <ZEsFhOKHs6yGLizc@x1>
References: <20230427-hammerhead-vibra-v1-0-e87eeb94da51@z3ntu.xyz>
 <20230427-hammerhead-vibra-v1-2-e87eeb94da51@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230427-hammerhead-vibra-v1-2-e87eeb94da51@z3ntu.xyz>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2023 at 10:34:27PM +0200, Luca Weiss wrote:
> Make sure all printed messages end with a newline.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>

Reviewed-by: Brian Masney <bmasney@redhat.com>

