Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636876A8BAE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 23:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjCBWXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 17:23:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjCBWXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 17:23:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9813A55527
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 14:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677795741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=an9MmHgGy0qzFZ8UIQUjGddxHR1f8bNnqbnky4ov8DU=;
        b=PD/yoAgDohl4hEgIpql5QGiX9rd3tAo8bNC6Xyt4mbxoGyuI+0MMlKMUP3KytL6/V+DGV0
        M0SYuWt53L1t/PW8z1mTPOc12RXlJib5C7qqJm+LkcN2GPwsm7ZJwo9UEcqf1EQY8T3JBv
        OEYKWijU+x7bvg2TVpUz2slWlJoHZh0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-t5LtG9rONcKnx67qbBJo4w-1; Thu, 02 Mar 2023 16:19:53 -0500
X-MC-Unique: t5LtG9rONcKnx67qbBJo4w-1
Received: by mail-qv1-f69.google.com with SMTP id l13-20020ad44d0d000000b004c74bbb0affso315507qvl.21
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 13:19:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677791993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=an9MmHgGy0qzFZ8UIQUjGddxHR1f8bNnqbnky4ov8DU=;
        b=LA8Iuyfwy7eHBDP7Iy5ghhe4i9OVzd/ZyJr4oYHafxkl+HZ7YA3QA6H4TLugBfyXoU
         wn9y2m2NZ8N0vz0Cb2DLOtCu4sHcMOZSw7xGJOIG4H7T92+QbPHRlfQiWwQh556uV+qE
         IeRKL+khb/gP602BrSESELfEQqj4fsEQwgHkSgnlMrVnQzlDL/lUkJR+Qx4uaa1iJZGN
         izXOfgjIQZkZrToo+V9ageyUkaHP7QD4dBvih9I3zY5iuQEdPhO4+KYFVu8Pxz+OsTJ5
         Ywvyw72HxyTsSjPIi8Vl8bYfsIu3daRa8zbT4v9aN/j+Wqqgm8OVy2g+ZvdgWx2j/vx4
         rcQg==
X-Gm-Message-State: AO0yUKV5i8LYrWFjDGxnGs3Yc4peI0so1lhVFTsna5G1vTUM+wfIelf4
        iWtufeRogROStQTClJGrUqcovAFCY31X1QcG1+9fmi7Hv3GMjRGMQNGZb7E/CFiMOWf5fOd+k74
        3CtDAygjc8ks3BE/K00IsC7tk6Xc0Rw==
X-Received: by 2002:ac8:5c86:0:b0:3bf:b0c6:497b with SMTP id r6-20020ac85c86000000b003bfb0c6497bmr22379665qta.2.1677791992765;
        Thu, 02 Mar 2023 13:19:52 -0800 (PST)
X-Google-Smtp-Source: AK7set8PF1hTlK8HTUITRVjlZRoMsJOKOmpk5rrOgeWX2x/xJfHaMGJ53hSke3jtLb29a+dxdnmWrw==
X-Received: by 2002:ac8:5c86:0:b0:3bf:b0c6:497b with SMTP id r6-20020ac85c86000000b003bfb0c6497bmr22379633qta.2.1677791992505;
        Thu, 02 Mar 2023 13:19:52 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id bl14-20020a05620a1a8e00b00706bc44fda8sm398391qkb.79.2023.03.02.13.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 13:19:51 -0800 (PST)
Date:   Thu, 2 Mar 2023 16:19:50 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 09/11] mm/vmstat: use cmpxchg loop in cpu_vm_stats_fold
Message-ID: <ZAES9hPHJGGgCBfc@x1n>
References: <20230209150150.380060673@redhat.com>
 <20230209153204.873999366@redhat.com>
 <Y//YREMSErJjiSzh@x1n>
 <ZACqvbnYAKumb+8O@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZACqvbnYAKumb+8O@tpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2023 at 10:55:09AM -0300, Marcelo Tosatti wrote:
> >   (2) If someone can modify the dead cpu's vm_stat_diff,
> 
> The only context that can modify the cpu's vm_stat_diff are:
> 
> 1) The CPU itself (increases the counter).
> 2) cpu_vm_stats_fold (from vmstat_shepherd kernel thread), from 
> x -> 0 only.

I think I didn't continue reading so I didn't see cpu_vm_stats_fold() will
be reused when commenting, sorry.

Now with a reworked (and SMP-safe) cpu_vm_stats_fold() and vmstats, I'm
wondering the possibility of merging it with refresh_cpu_vm_stats() since
they really look similar.

IIUC the new refresh_cpu_vm_stats() logically doesn't need the small
preempt disabled sections, not anymore, if with a cpu_id passed over to
cpu_vm_stats_fold(), which seems to be even a good side effect. But not
sure I missed something.

-- 
Peter Xu

