Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E54724067
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 13:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbjFFLDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 07:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236195AbjFFLC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 07:02:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92101E5D
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 03:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686049163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fjDXftYp5RUrNR1VA3ZUFoVwqX6agK4RoTjNejwdF8o=;
        b=FRsDr+5Eptr8P1kgJOhUfTSel/CEWm9jL2jVR0IQDsthMKw6wU65P33Wr4EEolXwKw9Cd0
        a//bsU/JMG/EnK/eGigJPDI/o7TjM5jKwZxqJO4Y7rttmuayLGjO3hETHboL7iPP4Pre6q
        7E2Fs8fCFrVIWK0QY4nFe6wR5v33xYk=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-FafI5_48OamKukWoINKHQg-1; Tue, 06 Jun 2023 06:59:21 -0400
X-MC-Unique: FafI5_48OamKukWoINKHQg-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-3f8654d47b4so5567861cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 03:59:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686049161; x=1688641161;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fjDXftYp5RUrNR1VA3ZUFoVwqX6agK4RoTjNejwdF8o=;
        b=cd0+nz8K7RmFZhlLXaRbexJ2Fc4wDbZ1GGhPJSK2bPaW46NQ1Xmu0UKPKrOXyDt5Pf
         g+FeP4fZbwmLQfDRRkFrBLbBwC7wnTwQMjATFlflOIh71kcb3xjEvFh6qKP4+sjgx1hB
         kPbM3mARrEibbwoH/Jwic059Vaq29MR82rW18noMGrxXlOCpNeFSoE+TtxUIJ4uN+KfQ
         s44a5MZr9E/FlWrIYyX9Gzth16sOQVNGCc4fePfQ3GozTj5zqKhdReHTEu8DpyBiNgwt
         HVwgLpS8TJlCyo08PEwjYoqrDd7xn6kC7aiz1K2mjH7jS7d9Ot/TXSi2Hv9ypU5VtgIr
         SwZQ==
X-Gm-Message-State: AC+VfDy8U+2/JBN80jCXcOwiXbUwlBYwhRY5pKCaN/oIdFhkVNog9RFk
        qK5lYnTaEQo1FJRld6a0OEpsjCyWoVP2tIa2YEwAoyHAXcBzNV+NYwvjG0QejqEJNC+Vu7E00Mc
        yOrHQvgudkT34wfGZT98DMpP6
X-Received: by 2002:ad4:594d:0:b0:625:aa49:a48b with SMTP id eo13-20020ad4594d000000b00625aa49a48bmr1681306qvb.6.1686049161487;
        Tue, 06 Jun 2023 03:59:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4860n1BYkfmXe2BunU1XbdTSEOrGqg2bogsqCCVtENchpUXVgVq2DDqvRz5QYJ0/KLaTL0Bg==
X-Received: by 2002:ad4:594d:0:b0:625:aa49:a48b with SMTP id eo13-20020ad4594d000000b00625aa49a48bmr1681293qvb.6.1686049161203;
        Tue, 06 Jun 2023 03:59:21 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-114-89.dyn.eolo.it. [146.241.114.89])
        by smtp.gmail.com with ESMTPSA id ep12-20020a05621418ec00b0061b731bf3c2sm5255180qvb.80.2023.06.06.03.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 03:59:20 -0700 (PDT)
Message-ID: <bedca9be6c496bbe9e124eda7ce13cf15bf7ca54.camel@redhat.com>
Subject: Re: [PATCH net] lib: cpu_rmap: Fix potential use-after-free in
 irq_cpu_rmap_release()
From:   Paolo Abeni <pabeni@redhat.com>
To:     Ben Hutchings <ben@decadent.org.uk>, netdev@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Eli Cohen <elic@nvidia.com>, jacob.e.keller@intel.com,
        saeedm@nvidia.com
Date:   Tue, 06 Jun 2023 12:59:17 +0200
In-Reply-To: <ZHo0vwquhOy3FaXc@decadent.org.uk>
References: <ZHo0vwquhOy3FaXc@decadent.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2023-06-02 at 20:28 +0200, Ben Hutchings wrote:
> irq_cpu_rmap_release() calls cpu_rmap_put(), which may free the rmap.
> So we need to clear the pointer to our glue structure in rmap before
> doing that, not after.
>=20
> Fixes: 4e0473f1060a ("lib: cpu_rmap: Avoid use after free on rmap->obj ..=
.")
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>

The patch LGTM, but please include the full blamed commit title into
the fixes tag. A new version will be needed.

Also add Jacob and Saeed to the cc-list

Thanks,

Paolo

