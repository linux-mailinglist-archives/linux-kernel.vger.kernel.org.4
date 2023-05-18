Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F0F7087CA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 20:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjERS3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 14:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjERS3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 14:29:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CF7E46
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 11:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684434528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZoOCyUhfshjqiWx1RRGNm+zxB7amhG6MwKVi2N7UXyc=;
        b=UI/PjRfEAKrFiWKjf8fISTg6AEyXPzMiCsFhglIv+hvqLWQqNU373i70pzSrJteHYzEVZj
        JYdiLTdoVvVqcHn7sTgEesR+d8qObsXVIyr6cqYjCO3MnQK9nlauo58lV4IUUKWUQc0LPi
        oIaKpQFU34PN2YoqKlmwtSxBcoF/3WE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-9-29MuU9M3CNBXtDEyOXwg-1; Thu, 18 May 2023 14:28:47 -0400
X-MC-Unique: 9-29MuU9M3CNBXtDEyOXwg-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-3f387b6d37fso34968631cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 11:28:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684434526; x=1687026526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZoOCyUhfshjqiWx1RRGNm+zxB7amhG6MwKVi2N7UXyc=;
        b=GmfKlTG8y7o64ZaGSzmCD5AKkz4xiflG0YZeHVoe7jKMD/BFbF/mChNbobU7ovHtpd
         +u3NsDWZI0Nu7HPwXBLBHvXfPEuzGnZO//W9cmRzWacboweZxRXuaqQ1wp8fmiCsmZnI
         7nL47tUwV51RPs10+DdLWfThU+Zlg4441QcYEX58YBJnVbi13Q+z9Uee93tbMwKLv5WE
         UD7ZAxeHPfULGnk8Y+E5RLi1l81MB1zyfnxQo6XseXGLL5Fw6QGTVLeeuhzX/tYuFCuX
         XtUEuYIehbRy1/D9QGNO62Hqcw7M4UUqjP6LRYKQyHt0oEZIPV+sC/JBydiKwoTdgSLc
         diag==
X-Gm-Message-State: AC+VfDxY5P2WymrFKD/hWFiVa13wGKNdvd/uoUDIGt56ejnKnUCXiXs4
        72Uy0rK2r0IGZJpZXVoTCM+aAqLR8iiWOLDFnKbKyE5N42uaCyLj9bgfBIiv5zxas5vBkFcCCvy
        Sm/S/7Qgp2FWitasBG7g8gck2yMzcfTJGlI92kdCY/wE6rqbfI6BBmMItki+w4xKBcFMPoMJPex
        TqjmdhtSuU
X-Received: by 2002:a05:622a:152:b0:3f5:41d9:fddb with SMTP id v18-20020a05622a015200b003f541d9fddbmr1163447qtw.47.1684434526297;
        Thu, 18 May 2023 11:28:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ78W2zAGWvSvDR1brUGAqTFQs3yXE6GKD14ttBdpFaqUXpLV7M9B6iNBpNGztxVS1Q6I6uXdw==
X-Received: by 2002:a05:622a:152:b0:3f5:41d9:fddb with SMTP id v18-20020a05622a015200b003f541d9fddbmr1163415qtw.47.1684434526063;
        Thu, 18 May 2023 11:28:46 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id x5-20020a05620a01e500b0074fb15e2319sm557599qkn.122.2023.05.18.11.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 11:28:45 -0700 (PDT)
Date:   Thu, 18 May 2023 11:28:43 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>, stable@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] tpm/tpm_tis: Disable interrupts for more Lenovo devices
Message-ID: <h7pelzgnae6kgrydhbp2ffoj4xctux3vx3s5yhiexskaykhcha@stxphc5cc3gy>
References: <20230511005403.24689-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511005403.24689-1-jsnitsel@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 05:54:03PM -0700, Jerry Snitselaar wrote:
> The P360 Tiny suffers from an irq storm issue like the T490s, so add
> an entry for it to tpm_tis_dmi_table, and force polling. There also
> previously was a report from the previous attempt to enable interrupts
> that involved a ThinkPad L490. So an entry is added for it as well.
> 
> Reported-by: Peter Zijlstra <peterz@infradead.org> # P360 Tiny
> Closes: https://lore.kernel.org/linux-integrity/20230505130731.GO83892@hirez.programming.kicks-ass.net/
> Cc: stable@vger.kernel.org # 6.2

For the stable folks this can be ignored though it won't hurt anything if someone does
backport it. The code enabling interrupts went into 6.4-rc1, not 6.2.

Regards,
Jerry

