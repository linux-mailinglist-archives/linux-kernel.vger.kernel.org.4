Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D91B7025C7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 09:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240436AbjEOHNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 03:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240519AbjEOHNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 03:13:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577FF10FB
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 00:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684134755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xwF3bMtKzTBdMVk3tiqEPsRCHZdEoAnjzKN67iE7ThU=;
        b=huMcrnHTpcxOYc/brtNEhEIbtjGgW3YLGQQZacxvfJ6KZCrSb/KH2+RLSeK+kd3ZDMcrg7
        5z2HvtsIa8RHKrhosxAxM+VJgOiswOS75p2LKziTkSjpe6RCpuhNbdZhFJhVRRmxocNWpI
        uFF8bE3FGyX596yFMkhSv15zR4q11bI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-nlOqEHQBN8ixUxul6Gd9ZQ-1; Mon, 15 May 2023 03:12:33 -0400
X-MC-Unique: nlOqEHQBN8ixUxul6Gd9ZQ-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-50d89279d95so22336378a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 00:12:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684134753; x=1686726753;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xwF3bMtKzTBdMVk3tiqEPsRCHZdEoAnjzKN67iE7ThU=;
        b=e9p3IR/W02HI7GAd7VUkRXEbs2uBsmP95nIU0finVHJzw7mgzz2jgGss5qwhIinFHw
         C3Y7zc4tXMtkGo8Ki0XSkZIXmcE0GyYmDf76Z7ZH7R/z/GQUnCbDMta42CGJYqc8MAdx
         H2WHyoynJ+zxLGENAY9+NyODL2FyfbpILzcBzUtsT+xHcprWD7wi0rVGQ1hZdcd9Za6R
         fNNsdhcdQ/aIiSwQZ4EPzH2ZFRJn8NWg6VqCprXq9wMwqHhMIdojtNpgDjy5W8hVELHi
         75FKnDNv5AMWlDhtkkOhRpbsYeH3wnS+lDL9fATjEQefRxIK00jV+Fgnms1X6DgNmyRe
         Dk+Q==
X-Gm-Message-State: AC+VfDxnDgPoPqvuPRMg0aBaeMs2VSXIGxVxTXND+v3+9Gbb/ozxzX1y
        SpI2ReGQ8NeRFbSsD+/pytQGKSMVHh/O9Ziji2yfxpI/MjB8SXlv+REwXxYcYK09l6blHbNAeUu
        kNuM1EzkLf1DsjLGsC6M34Nay
X-Received: by 2002:a17:907:2d0e:b0:967:13a3:d82c with SMTP id gs14-20020a1709072d0e00b0096713a3d82cmr24677032ejc.26.1684134752850;
        Mon, 15 May 2023 00:12:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6roqpg5jE0hXDmdOedggiZFhhlASXlWjExoRB/ZX0m8zeiDXY1K7sjvx8CPHbp5waK9vPFwQ==
X-Received: by 2002:a17:907:2d0e:b0:967:13a3:d82c with SMTP id gs14-20020a1709072d0e00b0096713a3d82cmr24677011ejc.26.1684134752575;
        Mon, 15 May 2023 00:12:32 -0700 (PDT)
Received: from [10.39.192.162] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id f20-20020a17090660d400b00965ac8f8a3dsm9178766ejk.173.2023.05.15.00.12.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 May 2023 00:12:31 -0700 (PDT)
From:   Eelco Chaudron <echaudro@redhat.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Pravin B Shelar <pshelar@ovn.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, netdev@vger.kernel.org,
        dev@openvswitch.org
Subject: Re: [RESEND PATCH net-next] net: openvswitch: Use struct_size()
Date:   Mon, 15 May 2023 09:12:30 +0200
X-Mailer: MailMate (1.14r5964)
Message-ID: <7EFC8D77-C24C-433E-8E8B-FBCF4387A7CC@redhat.com>
In-Reply-To: <e7746fbbd62371d286081d5266e88bbe8d3fe9f0.1683388991.git.christophe.jaillet@wanadoo.fr>
References: <e7746fbbd62371d286081d5266e88bbe8d3fe9f0.1683388991.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13 May 2023, at 9:25, Christophe JAILLET wrote:

> Use struct_size() instead of hand writing it.
> This is less verbose and more informative.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Change looks good to me.

Acked-by: Eelco Chaudron <echaudro@redhat.com>

