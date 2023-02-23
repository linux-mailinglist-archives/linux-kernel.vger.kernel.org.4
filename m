Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7948F6A0CB1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 16:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234278AbjBWPRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 10:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233429AbjBWPRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 10:17:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA73051FB3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 07:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677165394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NHNMILSu2gh+0ZNjvJdl/zHkMml7P+Yk5v5IpKXTRLs=;
        b=CNiYZw3PTgCvX9Sob+CTZR4A10oc67EKXwd1rtomE7KLjUznp6ps+Id4fXkXzIBPKeFb2i
        Fj9QUV1vqg6ttWjoABomWG+Y7zJAOX52bRArWJZEC6tNg8HHLZ9NQZxMe1WHvkcO4y9t1r
        lzLKmJmqV4MzHMVSoPiFFA7V+kk1hy8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-464-eEAoLQETOrqLn6UhlN4D0Q-1; Thu, 23 Feb 2023 10:16:32 -0500
X-MC-Unique: eEAoLQETOrqLn6UhlN4D0Q-1
Received: by mail-ed1-f69.google.com with SMTP id en10-20020a056402528a00b004acbf564d75so14498237edb.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 07:16:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NHNMILSu2gh+0ZNjvJdl/zHkMml7P+Yk5v5IpKXTRLs=;
        b=Sy5zpU6SByGtla7fs/DZYnJ0HJmYY27XqBchXmGTmEvnLA9Pzn7WDzjdCyoK3QNGCb
         +bjCDzT78RoAJ6IHtTWPRjKs3Ax+SLRpwbn/dpJRlMlJLCC1bhompy5AWq75IBLu7S1S
         v4ekUBVu58Olvwplgsf3DcY/R402wkyVtNv6AM3UTqY86VGNw4lMMnYpKyn7uB9CaoiO
         sle9R/VZGlP9VAOzwyj6CU1oMYnhJQjD5KeUrr1Gvx3gXz1XwcwV33nzERAGkFJGuMcm
         WFPgCnEHQRJvtsSvLoGqVU0QJD+xI/bAogrU58U/uk2SanVXptnNCqeDlj+edN13p8+i
         ZqKA==
X-Gm-Message-State: AO0yUKXPEDKEkyxD9iaUkP17kiIAsUgLJBmMVaR6UXs3znBCwzMmhKm/
        3GGRHXsj+Fha6N+9GlFYMh88d8PZDD3nGSUFXqLhWpD41gBHgPKoBbFmRR1FbyRnFXbyB2VpeFR
        WLicTG7WeY2b5F3zQqQAKIeCbk/hXH2fMb0NqnZy8
X-Received: by 2002:a50:935b:0:b0:4ae:f648:950b with SMTP id n27-20020a50935b000000b004aef648950bmr6428825eda.7.1677165391479;
        Thu, 23 Feb 2023 07:16:31 -0800 (PST)
X-Google-Smtp-Source: AK7set9bl/bgJWuLQyrwtx8szz2F6g37LHO2Y+hMZadqHccrzNcYXqW9sshlmlKXVksj3IyPGr9ZDHTslgWcY3fMLMY=
X-Received: by 2002:a50:935b:0:b0:4ae:f648:950b with SMTP id
 n27-20020a50935b000000b004aef648950bmr6428810eda.7.1677165391247; Thu, 23 Feb
 2023 07:16:31 -0800 (PST)
MIME-Version: 1.0
References: <CA+QYu4qxW1BUcbC9MwG1BxXjPO96sa9BOUXOHCj1SLY7ObJnQw@mail.gmail.com>
 <20220802122356.6f163a79@kernel.org> <CA+QYu4ob4cbh3Vnh9DWgaPpyw8nTLFG__TbBpBsYg1tWJPxygg@mail.gmail.com>
 <20220803083751.40b6ee93@kernel.org> <CA+QYu4poBJgXZ=RLTpQVxMeTX3HUSenWA7WZCcw45dzdGeyecg@mail.gmail.com>
 <20220818085106.73aabac2@kernel.org> <BY3PR18MB4612295606F0C22A1863FF44AB6D9@BY3PR18MB4612.namprd18.prod.outlook.com>
 <CA+QYu4pe47eYEUyEMC3n5iF2+qx30ff_duokWq-2z9b=UcpWzQ@mail.gmail.com> <20230222133433.7b4b0e67@kernel.org>
In-Reply-To: <20230222133433.7b4b0e67@kernel.org>
From:   Bruno Goncalves <bgoncalv@redhat.com>
Date:   Thu, 23 Feb 2023 16:16:19 +0100
Message-ID: <CA+QYu4qtGSiC_vUFq3gynMWYbZQN=c7Bnp7HvpLJObg7ndcxNw@mail.gmail.com>
Subject: Re: [EXT] Re: RIP: 0010:qede_load+0x128d/0x13b0 [qede] - 5.19.0
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Manish Chopra <manishc@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        CKI Project <cki-project@redhat.com>,
        Saurav Kashyap <skashyap@marvell.com>,
        Javed Hasan <jhasan@marvell.com>,
        Alok Prasad <palok@marvell.com>
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

On Wed, 22 Feb 2023 at 22:34, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Fri, 19 Aug 2022 09:36:54 +0200 Bruno Goncalves wrote:
> > We hit the panic by booting up the machine with a kernel 5.19.0 with
> > debug flags enabled.
>
> Hi Bruno,
>
> Was this ever fixed?

It looks like it got fixed, I haven't seen this failure on 6.2.0 kernels.

Bruno

