Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7EE6642C4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 15:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbjAJOHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 09:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233613AbjAJOHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 09:07:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8EC11C24
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 06:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673359561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L9zi9RalXX+v8RXF5p/DtEGhu0ZZ+UvkcK+8i6aWfa4=;
        b=fumOUau6JT311WxypR11sZh3mN3HK8S88p14u+TYsc3gxtUfkGBx0f7z74jcLljzCt2UTo
        uU57YiqP+uo0VfTwZiq/C6a/9LAOz3VC0v64c0oN188X/3+EQIhCJ7+qZKSLlCLDfRRKxO
        zf8v9d+e2f5zuph4hzNojevgHbRE3Y4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-590-6KuOp-ugNeuH5PpnU3dh4g-1; Tue, 10 Jan 2023 09:05:56 -0500
X-MC-Unique: 6KuOp-ugNeuH5PpnU3dh4g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 31C121C0040E;
        Tue, 10 Jan 2023 14:05:56 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B931E492C14;
        Tue, 10 Jan 2023 14:05:55 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 44EDF4052FE9B; Tue, 10 Jan 2023 08:50:28 -0300 (-03)
Date:   Tue, 10 Jan 2023 08:50:28 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     atomlin@atomlin.com, frederic@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v13 3/6] mm/vmstat: manage per-CPU stats from CPU context
 when NOHZ full
Message-ID: <Y71RBDZqV1Ad+GVr@tpad>
References: <20230105125218.031928326@redhat.com>
 <20230106001244.4463-1-hdanton@sina.com>
 <20230106150154.4560-1-hdanton@sina.com>
 <20230107001529.4617-1-hdanton@sina.com>
 <20230110024356.336-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110024356.336-1-hdanton@sina.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 10:43:56AM +0800, Hillf Danton wrote:
> On 9 Jan 2023 11:12:49 -0300 Marcelo Tosatti <mtosatti@redhat.com>
> > 
> > Yes, but if you do not return to userspace, then the per-CPU vm
> > statistics can be dirty indefinitely.
> 
> Could you specify the reasons for failing to return to userspace,
> given it is undesired intereference for the shepherd to queue work
> on the isolated CPUs.

Any system call that takes longer than the threshold to sync vmstats.

Or a long running kernel thread, for example:

https://stackoverflow.com/questions/65111483/long-running-kthread-and-synchronize-net

