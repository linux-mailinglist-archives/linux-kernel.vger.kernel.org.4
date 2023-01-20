Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D216754D0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 13:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjATMmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 07:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjATMl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 07:41:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35213BFF51
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 04:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674218434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g+HGkphiOiRdEWTLkrkQfvb64ugB3xmQDDmbxz6bl1U=;
        b=T12J8eyYvLnvgwROsHXlb7srOCWt6UeUdGfzBLGUk4iayqpPZY/HBYQ2AOZ1cGm0RB0MmK
        aRw5+f5BsaHbUOf65hEwJ41EQu6aL3S0Fi9DZfgNQ8O8whA87iKgkqNs6B/j2xLP+WEGjT
        TdPJu+AWpLeE/e4IUiABCC7l+DCqUuQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-551-bdIS85vDMu6fAWK2xhPVHA-1; Fri, 20 Jan 2023 07:40:33 -0500
X-MC-Unique: bdIS85vDMu6fAWK2xhPVHA-1
Received: by mail-wm1-f71.google.com with SMTP id c66-20020a1c3545000000b003d355c13229so4753412wma.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 04:40:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g+HGkphiOiRdEWTLkrkQfvb64ugB3xmQDDmbxz6bl1U=;
        b=8OlFphrFo311zLsqCgLxioNFsJFx6xli3Jg2VcFVFWi7msWUElvI4kaX7WDDmAHMqQ
         iEyd9Nc+EIO/ldVSV4aQXGqulx/UxLgB7Xd1/Jups55V5nivtzXepW8kV9G+rG1HoGQU
         xC/lCY42VU/YlnN8eBESJ32X23Mwz/XLz/hdQm2ukdDYgwAJ6ph7wkvGdrlSDZNIRGbG
         HXEn/Np0NzrlgSvvHF0XnYof9KccLgoEZgjrLAW6Jepb+Idc3jT6kh0ClxkCdqnjMyFH
         54AroK5Jl8zDSmcOkd42DlQ+qZZTbGvk536K41ETk3AJvweNsqcIFO9iDO5nARikJpnG
         MrwA==
X-Gm-Message-State: AFqh2kp4nLL1RJ/UIGY7rqdQgluDPJKSMPtvoy0L88DNiHK6gPjSQLRf
        b2tqo0pXZMRXwJgsJ9pjVUj5hdmID1P7P+g+LXNOQT1X8WP4rynCP2e3nRZpIOAJQJQMmkJOGmg
        20RYpB8AxkZMB/WUsSWezi2wY
X-Received: by 2002:adf:e991:0:b0:2b9:1a52:4f50 with SMTP id h17-20020adfe991000000b002b91a524f50mr21008673wrm.6.1674218432376;
        Fri, 20 Jan 2023 04:40:32 -0800 (PST)
X-Google-Smtp-Source: AMrXdXv0Ll2FYH05kUY/tQa/4cTBo62GBhghbxnCbiBnXTO2FiIz9W9LIKQVRJnl9g6oW5vBGFxE0g==
X-Received: by 2002:adf:e991:0:b0:2b9:1a52:4f50 with SMTP id h17-20020adfe991000000b002b91a524f50mr21008659wrm.6.1674218432154;
        Fri, 20 Jan 2023 04:40:32 -0800 (PST)
Received: from redhat.com ([2.52.19.29])
        by smtp.gmail.com with ESMTPSA id bt19-20020a056000081300b002bdc3f5945dsm23769465wrb.89.2023.01.20.04.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 04:40:31 -0800 (PST)
Date:   Fri, 20 Jan 2023 07:40:28 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, elena.reshetova@intel.com,
        kirill.shutemov@linux.intel.com
Subject: Re: [PATCH v1 0/6] Harden a few virtio bits
Message-ID: <20230120073942-mutt-send-email-mst@kernel.org>
References: <20230119135721.83345-1-alexander.shishkin@linux.intel.com>
 <20230120065402-mutt-send-email-mst@kernel.org>
 <877cxhqtdi.fsf@ubik.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877cxhqtdi.fsf@ubik.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 02:32:09PM +0200, Alexander Shishkin wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > On Thu, Jan 19, 2023 at 03:57:15PM +0200, Alexander Shishkin wrote:
> >> Hi,
> >> 
> >> Here are 6 patches that harden console, net and 9p drivers against
> >> various malicious host input as well as close a bounds check bypass
> >> in the split virtio ring.
> >
> > Hardening against buggy devices is one thing,
> > Hardening against malicious devices is another.
> > Which is this?
> 
> Well, the big difference is the intent, but buggy input is buggy input,
> they've got that in common and we're trying to deal with it here.
> 
> The motivation for this patchset is protecting against malicious
> devices.
> 
> > If really malicious, aren't there any spectre considerations here?
> > I am for example surprised not to find anything addressing
> > spectre v1 nor any uses of array_index_nospec here.
> 
> That's strange, patch 6/6 is exactly that. There's probably more coming
> in the future as the analysis and audit progress.
> 
> Regards,

Oh I see, didn't get it for some reason. Pulled it from lore now.

> --
> Alex

