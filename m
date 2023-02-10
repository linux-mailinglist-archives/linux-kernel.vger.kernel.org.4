Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4A4691AFD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 10:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbjBJJNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 04:13:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbjBJJNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 04:13:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B451A3772A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 01:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676020354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QcP66+mGB/CMJ6FBAYQszDN0y7xiLuPs6RLt7XSk6h4=;
        b=PZPt+4/0BNXOIX5MbPdgi5bzpWKT8fQARIdv5S2IJKcWvaGFNavQQcb5f6iI1xh/WcMux0
        oVj9uR/0JlG7KSLfxUL5y+Bh80ZhMZYfoLNnzfijCJBifyylCWcvKoQjsHLjEq8ODs0TBz
        o5o+4xTi+9el2LZvyZ+/XSoYLbf8TLw=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-492-X3zCCd7RM2qanp7mZg0fFg-1; Fri, 10 Feb 2023 04:12:33 -0500
X-MC-Unique: X3zCCd7RM2qanp7mZg0fFg-1
Received: by mail-oi1-f199.google.com with SMTP id u9-20020a544389000000b00363be5d9f42so1287858oiv.15
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 01:12:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QcP66+mGB/CMJ6FBAYQszDN0y7xiLuPs6RLt7XSk6h4=;
        b=KUtF8ncXOqUA4aVU8eyJwUiz2Wvw1jHJzeVeuEym3OR4Oee+seRSW4HuwmVQ0S7msa
         x4Ac7LLi9LjGfXbWwY3Tl3ewaVw4abBeKUeyij0NesaM0Mtxx7CN6ZQTVw2v/6zWdjr1
         0zupbETOUQzrwDzhIc/ufWz4w8sk8gW/sH0urwXRzsrWl2hRob1zlXSbYVbGzLldY5DW
         jXFdCI3WrgioBAQe2DDuSkjMJGdYVPQudK2DFYpj+bsBnHZhRrzHjpuDrs42Jt46HbiN
         uill+nV+tBqVWgOMKUeUmxKjeQE7PqOVIS77y9L/GA3bXnZy5safQG1MUeBWTcGrEEq5
         pqBQ==
X-Gm-Message-State: AO0yUKXjoSbrYb/8oRyeNvyr2J7tOGusrk/Z4u7mT+QQmWoVqskJFste
        07LZ3YbU0sa7GDbE5AIz7Z4l1CeqRmFAe/TOdXFGSbEZ8c34Hef4hbW18eUQZaJWzj/3OXpBa+r
        h19lb31QHyZ93YDEdi/vUkwO4uZEDGl9OI7R594pE
X-Received: by 2002:a05:6870:430a:b0:163:707c:124b with SMTP id w10-20020a056870430a00b00163707c124bmr1433046oah.10.1676020352822;
        Fri, 10 Feb 2023 01:12:32 -0800 (PST)
X-Google-Smtp-Source: AK7set/EJegEsENM7V+m6+Jtg5jDiE8FG91FQzXNEck4ZneudY944xVQOFHoTIleaV0uNM8rOEg5Qfg0KDD0d1rTVyw=
X-Received: by 2002:a05:6870:430a:b0:163:707c:124b with SMTP id
 w10-20020a056870430a00b00163707c124bmr1433042oah.10.1676020352597; Fri, 10
 Feb 2023 01:12:32 -0800 (PST)
MIME-Version: 1.0
References: <20230208113424.864881-1-mgamal@redhat.com> <SA1PR21MB1335F1074908B3E00DFA21BDBFD89@SA1PR21MB1335.namprd21.prod.outlook.com>
 <CAG-HVq8GYwCYBgiBnjO8ca5M27j6-MPK3e9H_c+EPmyotmOHxw@mail.gmail.com>
 <CAG-HVq9KWPRhy3X1E8vs_0y7xeJFBA-hZ5u6Vxh7H9Tu=gV9WA@mail.gmail.com> <SA1PR21MB13352C415EE6A3E9D3072991BFDE9@SA1PR21MB1335.namprd21.prod.outlook.com>
In-Reply-To: <SA1PR21MB13352C415EE6A3E9D3072991BFDE9@SA1PR21MB1335.namprd21.prod.outlook.com>
From:   Mohammed Gamal <mgamal@redhat.com>
Date:   Fri, 10 Feb 2023 11:12:21 +0200
Message-ID: <CAG-HVq9bYLv_whkNekuuNQsA0htBxM-jvS=NvDH9NB7bGfnw3A@mail.gmail.com>
Subject: Re: [PATCH] Drivers: vmbus: Check for channel allocation before
 looking up relids
To:     Dexuan Cui <decui@microsoft.com>
Cc:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        parri.andrea@gmail.com, Vitaly Kuznetsov <vkuznets@redhat.com>,
        wei.liu@kernel.org, Xiaoqiang Xiong <xxiong@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Re-CC'ing people from the old thread)

On Fri, Feb 10, 2023 at 4:57 AM Dexuan Cui <decui@microsoft.com> wrote:
>
> > From: Mohammed Gamal <mgamal@redhat.com>
> > Sent: Thursday, February 9, 2023 1:48 AM
> >  ...
> > > We saw this when triggering a crash with kdump enabled with
> > > echo 'c' > /proc/sysrq-trigger
> > >
> > > When the new kernel boots, we see this stack trace:
>
> Thanks for the details. Kdump is special in that the 'old' VMBus
> channels might still be active (from the host's perspective),
> when the new kernel starts to run.
>
> Upon crash, Linux sends a CHANNELMSG_UNLOAD messge to the host,
> and the host is supposed to quiesce/reset the VMBus devices, so
> normally we should not see a crash in relid2channel().

Does this not happen in the case of kdump? Shouldn't a CHANNELMSG_UNLOAD
message be sent to the host in that case as well?

>
> > > [   21.906679] Hardware name: Microsoft Corporation Virtual
> > > Machine/Virtual Machine, BIOS 090007  05/18/2018
>
> I guess you see the crash because you're running an old Hyper-V,
> probably Windows Server 2016 or 2019, which may be unable to
> reliably handle the guest's CHANNELMSG_UNLOAD messge.

We've actually seen this on Windows Server 2016, 2019, and 2022.

>
> Can you please mention kdump in the commit message?
>

Will do.

> BTW, regarding "before vmbus_connect() is called ", IMO it
> should be "before vmbus_connect() is called or before it finishes".

