Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091C46BBFAE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 23:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbjCOWSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 18:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbjCOWSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 18:18:01 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97577359B;
        Wed, 15 Mar 2023 15:18:00 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id k17so8512878iob.1;
        Wed, 15 Mar 2023 15:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678918679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DVMB/3d/5mvlYp5jK5eg+JXYkpAvNpppGnciNj1lrN4=;
        b=QBZdmFY2MFDOHmPKiKocXUdgJTB1HlI4GHPyLY/c0qaBoakt4ZK+bJ6FvcB41aXH4o
         qhU8m+efoy1vK6w6sDILq/Dk5Rp1ajBeUHDvo3cPurCP8wUOV8Ysi3KSHe2QccVhBfhR
         PpHa4pmXPS2ajpy2lq+9MO9Zg+noKHHFRG7aKp3awr7imhgh31HB9N9jUzCe3JnI4odC
         iwDWWdJNUivVxC1BSO/7fmLU3XZRTOBa4EclyvSp/irs/xr/CR1gWAPqyTfvWu1ofHqI
         cMXvGUpim15n87E7wnQ5eJdlwxqnE7aewKgVEiF3hT2N9YUnUKGfqVQG5yKZysBB65Yh
         H3YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678918679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DVMB/3d/5mvlYp5jK5eg+JXYkpAvNpppGnciNj1lrN4=;
        b=CnSIN8ZjcEdMQk0vBEoEWIvDdgKFHc6e3Oi6fUQN+SwZI2o2iGXBYyKILZkp7OEsQ3
         WHFnt5QQuEBVQvk3u+4KLommbl14smJXqsp7LGaBU7WeAJqp1KSOMpv2FhhGrphe38P4
         m+8MMvdIiHJopFdOiAxM58yu+XgoVPsMU7vmFhdvP+Em4Nb7LQx863k+0aPeTnvkfMqI
         bHIY/gZW+YQSOPW9LOPwZBDVO0HLsMMA1y5Xz9rG4u3TvLY1ikZ0bcRm/uyyjdr+U0fI
         WTASSI0B2U7MpEYqGTFAGd7hB4HaG4qaBmD1aAiS9LnBjEzs6KuqlaL26FznAvaRfP+u
         htww==
X-Gm-Message-State: AO0yUKVYsBd71xDG9kqndlhS2CdYfb9GBZxsSz428Nz+FHBp72WE0D/z
        cbJzsqI+nh7YAhw5KMYvMAsX2kzhzKo=
X-Google-Smtp-Source: AK7set+RkVKrE7gZLi4DDS6qZ9mE/Qs+JCpVr5KBbLjpHIne8sdp9eO9GhrTXVQc2Pyq798T9EXSZQ==
X-Received: by 2002:a05:6602:2188:b0:74c:bb78:25d7 with SMTP id b8-20020a056602218800b0074cbb7825d7mr27182025iob.19.1678918679748;
        Wed, 15 Mar 2023 15:17:59 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g17-20020a05663811d100b0040613520534sm1224485jas.118.2023.03.15.15.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 15:17:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 15 Mar 2023 15:17:58 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Denis Pauk <pauk.denis@gmail.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, mischief@offblast.org,
        de99like@mennucci.debian.net, holger.kiehl@dwd.de
Subject: Re: [PATCH 2/2] hwmon: (nct6775) update ASUS WMI monitoring list
 A520/B360/B460/B550...
Message-ID: <7176f60a-3c47-4189-9834-e3493f62cd21@roeck-us.net>
References: <20230315210135.2155-1-pauk.denis@gmail.com>
 <20230315210135.2155-2-pauk.denis@gmail.com>
 <20230315233054.5ac21db0@gmail.com>
 <19097c39-9703-6b7f-6cc4-8a157b00f368@roeck-us.net>
 <20230316000453.553bf6a8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230316000453.553bf6a8@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 12:04:53AM +0200, Denis Pauk wrote:
> On Wed, 15 Mar 2023 14:58:24 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
> > On 3/15/23 14:30, Denis Pauk wrote:
> > > On Wed, 15 Mar 2023 23:01:35 +0200
> > > Denis Pauk <pauk.denis@gmail.com> wrote:
> > > 
> > > Tested-by: Holger Kiehl <holger.kiehl@dwd.de>
> > > 
> > > Pro A520M-C II/CSM is also tested by Holger Kiehl
> > > https://patchwork.kernel.org/project/linux-hwmon/patch/868bdc4f-9d45-475c-963e-f5232a8b95@praktifix.dwd.de/
> > > 
> > > Could it be applied as single patch or need to rebase over "Pro A520M-C II"
> > > patch?
> > >   
> > Sorry, I don't understand what you are trying to say. I just applied all
> > patches in sequence as received, with no conflicts. Should I undo that ?
> > 
> > Guenter
> > 
> 
> No, Thank you!
> 
> I just like to mention that Holger Kiehl sent separate patch with
> "Pro A520M-C II" support and it could create conflicts. I have found it only

It didn't.

Guenter
