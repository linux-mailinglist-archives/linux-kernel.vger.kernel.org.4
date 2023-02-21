Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66E969D91A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 03:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbjBUC73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 21:59:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbjBUC71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 21:59:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFB5FF27
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 18:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676948320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cUGVQQU8ha9dToISO+nXbL4NaXJXQDIYfr67WAN1gbY=;
        b=EO771WHcFVdkyFE0dneTFK9Jn9/p+ZvE0lTE2XbsewhAHkemM2dusfezM8fZzR6Vi+kiO0
        UD23DktyFPVjX8qSDR5YurXb8w25X5bvW74wf6SlApXkkI88zvJhmdBx/zvKAvRjEQAool
        cnyKYWvE3K5NLPHsO10jgF+iI/6asIc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-479-FQ41QykvNHuE9-lWY9jfyQ-1; Mon, 20 Feb 2023 21:58:39 -0500
X-MC-Unique: FQ41QykvNHuE9-lWY9jfyQ-1
Received: by mail-ed1-f69.google.com with SMTP id g24-20020a056402321800b004ace77022ebso3953571eda.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 18:58:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cUGVQQU8ha9dToISO+nXbL4NaXJXQDIYfr67WAN1gbY=;
        b=CF59t8wUiOtEuu7z/z9zYLEzXJiULrNsvAGmB4q4dweeFEJ6SrBnrtvLZU7IN3GL0J
         TUtvnYNQSFlyQZMv/AGaWRPbIksdBXIhBdg6MeIZZqsrak2+vk9M8sO/xIKk1dZNXZCi
         7bbrEHuKkgWyING1PiKjNjrjWNrom23rlqtB/+6v3C65H4ZvcrPNPC/w6F9eCB5DyZiH
         b5Xkj7mbv2nkUbdQ16ArUxarQuXcfw+BaR50TqB9VOTLLTbLALSdn8MzwvMXrn0Ks4hu
         l8v2UktSHe8uFCRNlKQx6jDqeFNDZuiwkuS8EF+UpmVINcyYwXJMyZfvptAx+xdI/Lcl
         DevQ==
X-Gm-Message-State: AO0yUKW381I9ovx8BV+xA95Q42mVnui/43G0i+KeiLotr5JS5jv/g/8H
        R3qk9fJoDidaJuzhACwwpNB4OEK04mO/nPL6nD9gOa7Vo5qUUhm7uqrNkG7WJ3NxA+EmRZZyKSa
        tpYr91SBRZ2wEMUBXhcChWWpEmFAS9S2kaZLLy/Jy
X-Received: by 2002:a17:906:2495:b0:8b1:78b8:4207 with SMTP id e21-20020a170906249500b008b178b84207mr6514328ejb.3.1676948318204;
        Mon, 20 Feb 2023 18:58:38 -0800 (PST)
X-Google-Smtp-Source: AK7set+CvuVTnLCeVgyoWH144+JTZH3cGPtR6y81s08i+zAv8rU14G3AI8BBjVFPQPoDXxX/nq2OI2Y5rnkTQoFU6Go=
X-Received: by 2002:a17:906:2495:b0:8b1:78b8:4207 with SMTP id
 e21-20020a170906249500b008b178b84207mr6514317ejb.3.1676948318004; Mon, 20 Feb
 2023 18:58:38 -0800 (PST)
MIME-Version: 1.0
References: <20230218211317.284889-1-stefan@datenfreihafen.org>
 <20230218211317.284889-4-stefan@datenfreihafen.org> <20230220095944.6be3ceec@xps-13>
In-Reply-To: <20230220095944.6be3ceec@xps-13>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Mon, 20 Feb 2023 21:58:26 -0500
Message-ID: <CAK-6q+h+o8DFV07oFLHPbPF5nM+gexQFUnFwsC7+Z6e8v8J8Mw@mail.gmail.com>
Subject: Re: [PATCH net 4/4] MAINTAINERS: Add Miquel Raynal as additional
 maintainer for ieee802154
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Stefan Schmidt <stefan@datenfreihafen.org>, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-wpan@vger.kernel.org, alex.aring@gmail.com,
        linux-kernel@vger.kernel.org, alan@signal11.us,
        liuxuenetmail@gmail.com, varkabhadram@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Feb 20, 2023 at 4:01 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hi Stefan,
>
> stefan@datenfreihafen.org wrote on Sat, 18 Feb 2023 22:13:17 +0100:
>
> > We are growing the maintainer team for ieee802154 to spread the load for
> > review and general maintenance. Miquel has been driving the subsystem
> > forward over the last year and we would like to welcome him as a
> > maintainer.
>
> Thanks a lot!

welcome :)

- Alex

