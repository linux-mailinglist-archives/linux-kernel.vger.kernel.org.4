Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB27A73A6CC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 18:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjFVQ64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 12:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbjFVQ6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 12:58:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8115A171C
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 09:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687453082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gAWxNjxnJA5QCZuC21KgBhCKxi4eQ+4jpeKcX1+CbJE=;
        b=IjTCL+uSYURZvC87RmB/iedCmPcb+9kdGYxhuWaf870Tnup1O9KP5hTja29Fhpf9nUDMCh
        /7Mb9AOTN3mIyrPjoJrBqmeL7ZHMppZMjx76gHOSNb83WytC+YGR9T1kKQIDpyy2tR9PB1
        ib4qd0h+SuQ/KXkmPVJQ3bhQyhKozlM=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-oxMZY9XkPaSd7uD6nbMPnQ-1; Thu, 22 Jun 2023 12:57:58 -0400
X-MC-Unique: oxMZY9XkPaSd7uD6nbMPnQ-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-1a98707b4f9so6704309fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 09:57:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687453073; x=1690045073;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gAWxNjxnJA5QCZuC21KgBhCKxi4eQ+4jpeKcX1+CbJE=;
        b=Rn5sti4r9YmhgUv3Qacg8F7l1UuXkvK9n6Gkl5TSLPsLmF/H3+DHvw7kOcfKAT55Mh
         Dw1xy4GlnPSIW0MJR6sJloTPolIyDhbA+dUjzU18NubiszPdYJ6E6l1OEEHcBlksDYiq
         tABu3XXOZxVMFhceX4x7Ie7Pi8gGhMMaOlk9fan+NMM+RRzr8FDDtAXCLkaIyWA/vAJP
         WJc6y8UBFvO8SQkqafoFZqd7+hgFysldu1JYaXLLcxehwszZ9pZ8pJ0JzfeiLeUzovzx
         K+m6w6O9ILsB/8JXa0e6kb5vWBC5dtlsX6DZcw0q0gRXwcuwOBSj4SkxxcrAC+kdU+SW
         eDUQ==
X-Gm-Message-State: AC+VfDwn+tKpt7YiYGOpcW4Fl94oQJ687LIC45vZUAOBLkuhJIuwBOF8
        HsxBSzExE+li9ZUYRf0ll9bKxLtESsXYYSRqjpn0do3N4wIpV7W03KDQ5zLEFZ8ejF22lHASpsu
        0klgAeDvRK4x2RRwsLRe5cmIW7WgoGnyfuTg8BYIdoDuH5ME1DwU=
X-Received: by 2002:a05:6870:9202:b0:1a2:a6e8:9832 with SMTP id e2-20020a056870920200b001a2a6e89832mr14821068oaf.42.1687453073603;
        Thu, 22 Jun 2023 09:57:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7qMzXwVZhsP3YURXvCdNBdCdVaT/83FElq+TxTMvTCIeN2GPAsQiFS/opK9wjGO8ykDYr9ONOA8/x+vU7B/Bk=
X-Received: by 2002:a05:6870:9202:b0:1a2:a6e8:9832 with SMTP id
 e2-20020a056870920200b001a2a6e89832mr14821059oaf.42.1687453073421; Thu, 22
 Jun 2023 09:57:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230622071004.2934698-1-costa.shul@redhat.com> <a0e8aba6-b28f-c460-9bab-5695000727fb@infradead.org>
In-Reply-To: <a0e8aba6-b28f-c460-9bab-5695000727fb@infradead.org>
From:   Costa Shulyupin <costa.shul@redhat.com>
Date:   Thu, 22 Jun 2023 19:57:42 +0300
Message-ID: <CADDUTFy_e61TfMkxE0f7Lnt5QXA09YKi-0rx6ULmw+9LQ00FbA@mail.gmail.com>
Subject: Re: [PATCH] docs: consolidate core subsystems
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2023 at 18:36, Randy Dunlap <rdunlap@infradead.org> wrote:
> a. I'm not sure that locking is a subsystem (it's a core API IMO).
Actually https://docs.kernel.org/locking/index.html describes more
than just API.

> b. I often have trouble finding "filesystems" and I think that it should be
>    given a higher location in the TOC (somehow).
I plan to put "filesystems" under "Storage subsystems" in the next patch.

Thanks
Costa

