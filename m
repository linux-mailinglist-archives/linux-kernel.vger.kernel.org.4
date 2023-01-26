Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91DD667C74B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 10:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236916AbjAZJ31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 04:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236836AbjAZJ30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 04:29:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4E821A2B
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 01:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674725307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hlpy8oMhkjt4kiolXYLNtGmM2K2CX6szoOfA13GZPeI=;
        b=cD8v1MaoxPAJEd+ccGHCYThBeTptBoiCTBIF4hKlT6bXWOjotE6yBBmS6hT9t7qmG4ujhp
        6beeLS813MQlF7IVf2Jzu5klPq1oVcxeaziVp0jZGszjIZmr3kzvZ/xkuTZ+LopLGbpnqc
        cuIxvQOYkyLpDuqG/sp1n5CZD+H4V/c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-663-OE4svBXRPnGUxPCdWi8CWg-1; Thu, 26 Jan 2023 04:28:25 -0500
X-MC-Unique: OE4svBXRPnGUxPCdWi8CWg-1
Received: by mail-wm1-f71.google.com with SMTP id 12-20020a05600c228c00b003db09699216so277731wmf.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 01:28:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hlpy8oMhkjt4kiolXYLNtGmM2K2CX6szoOfA13GZPeI=;
        b=Q/FDe2P8KgCpshPTxUVZNDQPoX2x99p5HBjkSFDZ1TDHoeoTmhZ6msUayPGO4NGlSW
         tpqtAtsZ1e5pKqjKwqnL72M4ssNKro9PONgILTG6sUusbHbWg3rNkxDHSde1UoSX8hzY
         GpwABG6pKWZWivFYRTMaDjUoWfv8W19xvSg+6yeWIGeLzuxMeXU3P0x9tcLTJUPyeuUI
         IrE04rmGRwFQTjuIG0kiTQgzvCQpaTgGcotrputKaBCDnEvA7T7QSfboCcONAKWN1kCP
         UdhoRFw3M4mw+kajMtFHOK3TTJXyEENmn4UZ6gw92juLy2i08oJZ6Ma4RNxadc+4TkZp
         5jVA==
X-Gm-Message-State: AFqh2krZzDnhwmQX1h9EIaA3NxrubK7Hjm78ln1duqUCeRJaRWJFjzdD
        rNKJom3nOba9U9O9odFQt86CXMuwxmrLP4wK/Th3HkIHk7IUP5ssGk1Kx2j8PRpQ3vI3tjIE17o
        siJ9UerorTg6sIeP5GdqbxAXT
X-Received: by 2002:a5d:6b09:0:b0:2be:110d:5d59 with SMTP id v9-20020a5d6b09000000b002be110d5d59mr29514208wrw.51.1674725304550;
        Thu, 26 Jan 2023 01:28:24 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvUubeSQ32vzl9stAsN2dulKbFqGtYmFtL06g225jZTpyT/iCMWZw4XveGa5u+qTWONOqnjnw==
X-Received: by 2002:a5d:6b09:0:b0:2be:110d:5d59 with SMTP id v9-20020a5d6b09000000b002be110d5d59mr29514191wrw.51.1674725304256;
        Thu, 26 Jan 2023 01:28:24 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id f28-20020a5d58fc000000b002be5401ef5fsm629228wrd.39.2023.01.26.01.28.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 01:28:23 -0800 (PST)
Message-ID: <2f39d449-f760-db73-5da5-9d7016f1350f@redhat.com>
Date:   Thu, 26 Jan 2023 10:28:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v10 5/8] block: Replace BIO_NO_PAGE_REF with
 BIO_PAGE_REFFED with inverted logic
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
References: <20230125210657.2335748-1-dhowells@redhat.com>
 <20230125210657.2335748-6-dhowells@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230125210657.2335748-6-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.01.23 22:06, David Howells wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> Replace BIO_NO_PAGE_REF with a BIO_PAGE_REFFED flag that has the inverted
> meaning is only set when a page reference has been acquired that needs to
> be released by bio_release_pages().
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Jan Kara <jack@suse.cz>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: Logan Gunthorpe <logang@deltatee.com>
> cc: linux-block@vger.kernel.org
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

