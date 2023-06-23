Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C9B73AFAB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 07:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbjFWFAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 01:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjFWFAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 01:00:40 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF57F2136
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 22:00:09 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-3f9b4a656deso3705391cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 22:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687496409; x=1690088409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j/RGEzgP+aqX5ZY+j/ilBaNLtUkbB2eFzGxCWwZgKCI=;
        b=GLZRJdbgGtTqv7kuctUIXxgb6cawBVQJrpcuN5/GhnjlegY1NFLoLH7zHLxkjNFaZQ
         b94r93Hm6d+QZBJ4eK8rvvJpcT+5f2Dxs4Rxs7CuEreXRvcS6s9gI41FWfy+nLu/YXLD
         8BvhLEDbRu1sPIhCjlrKMq7D0xO4NFpgxMcrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687496409; x=1690088409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j/RGEzgP+aqX5ZY+j/ilBaNLtUkbB2eFzGxCWwZgKCI=;
        b=NsTHCxrdOIncRRTg+1a8wyVTbK7rXYrSnEgpKhdHLagPyapvRpJS2D0oA0m+G61MNz
         9mnj+7kAzrHI0MoKefgqkglfmMTLhASgqypMjhQoUBh7WYBD5u74OLE1X2zu49yuqmWJ
         zZk1uGP+EEwuGyTILnN3GrZ4+5+991M892QWQu3pfT0cnfDfuzCN+lxeW8Ffm3B/lLnf
         DfNXru1LwWECJWdJyVmsM1GP40zVp44Lq+8RirOxpS+Sv6C1gdaIFzh0TApVLi1Zh9Qm
         M/xIPGyYMx1j5R+1VTHmDYfOIn/NWQoJ2J8RS50vJjWXVmY+zmAhok9msq6SRn9+s4eG
         wjxQ==
X-Gm-Message-State: AC+VfDztNnZN8Jr33JW09CNuGc4o9D6cXiFSnGJ7FGEDD+nPfS+iPKK7
        ocgbZYTPxbnOR4LeuBkTXqF3tg==
X-Google-Smtp-Source: ACHHUZ5ZnGLETi8vnh4wvIFB6bEndLB6axcJukRFIugGjuXOszeZs9XSIiD//UEa+RbqdfXKgyAuyA==
X-Received: by 2002:a05:622a:507:b0:3f8:6924:a0b6 with SMTP id l7-20020a05622a050700b003f86924a0b6mr24623761qtx.50.1687496408922;
        Thu, 22 Jun 2023 22:00:08 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:3383:b451:fa2:1538])
        by smtp.gmail.com with ESMTPSA id n4-20020a635904000000b00553b9e0510esm5487913pgb.60.2023.06.22.22.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 22:00:08 -0700 (PDT)
Date:   Fri, 23 Jun 2023 14:00:04 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <sfrench@samba.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ksmbd: Use struct_size() helper in
 ksmbd_negotiate_smb_dialect()
Message-ID: <20230623050004.GA11488@google.com>
References: <ZJNrsjDEfe0iwQ92@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJNrsjDEfe0iwQ92@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/06/21 15:29), Gustavo A. R. Silva wrote:
> Prefer struct_size() over open-coded versions.
> 
> Link: https://github.com/KSPP/linux/issues/160
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
