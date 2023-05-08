Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51DAD6FBBAF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 01:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbjEHX5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 19:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233880AbjEHX4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 19:56:55 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCA8448A;
        Mon,  8 May 2023 16:56:54 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1aafa03f541so51089985ad.0;
        Mon, 08 May 2023 16:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683590214; x=1686182214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2YJeCVahMakSFFIeHkE0L5vaAYWzeS9qst+vBo++bi0=;
        b=Ph0git+M3JFD2GZ6Ui+oTj2N8WYsxQCABPF8XsCHQ3g9cgYJyZ2iVi/xFUDxLPYACz
         KWf+aY8fQF9IRdRZyzDKBzo9FnS2pGHrBZoOhIvUumu9j/UZi1wZWpo9aI3yOgCvuusg
         Tn62mePVj4DnQ+1enEDDZNPIj1+lbHegpc2PxSdjc2UkW2EBVE+OBt1yRaJjomuLol7K
         C09QLSN5cFVxKjYuO5336KJ6sBAnOKK4iEkCC1X8LHGMWia0yvCVuAzbjFJo1vRx07V7
         Z4jJAwzBErzsueryquC9JMzkOV6plb79M7XMAlq8vPJccIAAumOQ5iQsygIl4/ykclux
         gaSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683590214; x=1686182214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2YJeCVahMakSFFIeHkE0L5vaAYWzeS9qst+vBo++bi0=;
        b=Idqr08pe8Ziemhw7KLD3AxLPTF71Ar+VOJbglB0ntoOwGilptX9jVSPY5iF1aYQ7Ua
         wVVhb84HRTtTvwFdvSDFl7tVkSdfpliScoCwCc6jgip2n9sRpZM6gZL/5SmE5qfsejwx
         DwHaIJ24mF33XOYM7oN2Opa1ax7IpNcPVUA6AgkvXuriSmiBXtclIXBVcFTC7MsFRxMx
         txesjxwnxeAWwvdSRwye5EsDivxLxzzlGxRIg0B9jiJPlymz6kO2Oo64zYExwUT3jRph
         TvSmiE1Btc9pFIxnWm3DoBEiAJtq1ig28aAqi2IOGvhwTh7dPgdQFyprPx2H9u7v7YtU
         Q8sQ==
X-Gm-Message-State: AC+VfDwDoJyUVSs3yFMn3BUEZMUWP+5dXb9MMCK6ucN8LbztdnIcrB8q
        f9jZvSau3lp+p6NscBkM3QI=
X-Google-Smtp-Source: ACHHUZ4J9qyAt8IjXUu6z/kB3DX9QIpK7MBmUHzJNiGCYtU/+V1cf3Ok0bogmgDJFnYzKrERaxOM9g==
X-Received: by 2002:a17:902:b70f:b0:1a1:b3bb:cd5b with SMTP id d15-20020a170902b70f00b001a1b3bbcd5bmr12235342pls.62.1683590214192;
        Mon, 08 May 2023 16:56:54 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id iw17-20020a170903045100b001a2104d706fsm41392plb.225.2023.05.08.16.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 16:56:53 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 8 May 2023 13:56:52 -1000
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>,
        Srujana Challa <schalla@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>, netdev@vger.kernel.org
Subject: Re: [PATCH 07/22] net: octeontx2: Use alloc_ordered_workqueue() to
 create ordered workqueues
Message-ID: <ZFmMRI4OGgw_rwp8@slm.duckdns.org>
References: <20230421025046.4008499-1-tj@kernel.org>
 <20230421025046.4008499-8-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421025046.4008499-8-tj@kernel.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied to wq/for-6.5-cleanup-ordered.

Thanks.

-- 
tejun
