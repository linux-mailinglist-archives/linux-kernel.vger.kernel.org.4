Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF9B74BA4D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 02:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbjGHAAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 20:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbjGHAAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 20:00:45 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2A22119;
        Fri,  7 Jul 2023 17:00:44 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-55b83ae9be2so1698894a12.2;
        Fri, 07 Jul 2023 17:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688774444; x=1691366444;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=paDVfCnqjf1m1yOGTipqvAqR+8Z3FFsNpIqY03z8GNs=;
        b=VweILxprXbLUdy0Dpi+PG2MqFUGWfHs3LtU4Roea0L/QdXFeALcuLGa/3nlWvIg6/T
         FDN3BOQgJ0hGDJ2Cy3kHkxXPjTJ2F2jhDf6YoW1qy+QSf+aCjlqqdiXihKMnvaNbID1J
         WnlG7q6wdM2LEYLoD2mpVf90basFtS9v5BJArAyFoHAWMgfnPtJGPSi6SBWmLFEWnPgW
         7fwgLx+EBIWp2vR47stNIBEMMUgIKZMW3xeM1UwMurBOUzai7a2eQHBOB46asMacxyu3
         KawyZwLpotfYlsN6vGP/WLjRblJN0Q3NjkkVdY2NgL6Fl9Q83wOKLJ1oZGtChFlfbtrI
         KtDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688774444; x=1691366444;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=paDVfCnqjf1m1yOGTipqvAqR+8Z3FFsNpIqY03z8GNs=;
        b=ioARx3idqnDbFlSBnO1Rk87rLT0BRj0BndN1eFEccnPxXLqPKApm01gla3k+FQcgX+
         iUdrgFIcvtEunm5ZbCK09EXW4VBBhPXQNy/8bm17D4kDOvzC7mMbmMw2WoJsOSBJ/978
         DFvnCTA1DY2E/ptD9QVlwSAEg17dEDYgwbCF4AxCtvAmPqNHjKc+YxpJ2PgVGP6dE7hz
         4nfignpr6LuP5E5rNweW6GI+5DPo4D+BsQNWGTIzvbR/2fnhEGITzjx82320Jv8Obhe6
         sqQjxhBf/7ahgj7WS+eZiRsAarz50eVYktbgSsSGN/jsyM9SWcXm2hIO+ghSfbHtln6k
         CPvw==
X-Gm-Message-State: ABy/qLa5OIvczvPyBfA5Fh2vAgnugH33Dhe5b6kOHf/NFg12v29H+qdr
        MsJDWdiN0cniipYOGAPxRVw=
X-Google-Smtp-Source: APBJJlHX6Iel6xly0mIuB8TkKf3dvlhC3Q8e3/mWn2nxpvyqK3P8F6lW4h3lXlsThgWp0UXnNNZy/A==
X-Received: by 2002:a17:90a:6486:b0:25b:f66c:35a9 with SMTP id h6-20020a17090a648600b0025bf66c35a9mr5591564pjj.48.1688774444184;
        Fri, 07 Jul 2023 17:00:44 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:38de:2bd4:8f55:60cd])
        by smtp.gmail.com with ESMTPSA id g8-20020a17090a4b0800b0025dc5749b4csm1991594pjh.21.2023.07.07.17.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 17:00:43 -0700 (PDT)
Date:   Fri, 7 Jul 2023 17:00:41 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: Input: exc3000 - Support power
 supply regulators
Message-ID: <ZKinKboyNGZrQCPG@google.com>
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.067a6add-28c9-4499-a235-882581bddc85@emailsignatures365.codetwo.com>
 <20230707131042.10795-1-mike.looijmans@topic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707131042.10795-1-mike.looijmans@topic.nl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2023 at 03:10:41PM +0200, Mike Looijmans wrote:
> Add power supply regulator support to the exc3000 devices.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 

Applied, thank you.

-- 
Dmitry
