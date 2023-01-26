Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F36967C752
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 10:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236933AbjAZJaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 04:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237027AbjAZJaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 04:30:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E819EFB
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 01:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674725355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q00Xxn1cD6lPjr/aMO9QR9HG5kM9NAzpDCX3OBr9UoI=;
        b=F8mMIOehRI+vg86xz9xXtnwa8LjfrLW9g1eM+H/x+DANcFZVgsJtZxwIfwowJEuNEwJBlZ
        Cct8pBj6iHO1s8CNGpvzxs5fqERSVnwxTgboC5n2GlFM0j+1s4tc5VnEGvafIEkCkGyDxp
        7yogqnJw1V3q4RW0g+BrNUWXCS1nARw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-468-TlOkGlqtNkOpBgpBKG04iw-1; Thu, 26 Jan 2023 04:29:13 -0500
X-MC-Unique: TlOkGlqtNkOpBgpBKG04iw-1
Received: by mail-wr1-f71.google.com with SMTP id t20-20020adfba54000000b002be0eb97f4fso158404wrg.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 01:29:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q00Xxn1cD6lPjr/aMO9QR9HG5kM9NAzpDCX3OBr9UoI=;
        b=7KOPvZjevrTuvulYYkzi66kGqqhDUtKU72odb8VnT6ERuQaRRpKEYHInsw3sWHKGIT
         u8LKElTqYScrj8Jlvnb6lQAMP6m/J12X3Bplb+vHQjRSU7Lw3RZfPjuszAECiKZn4Dbe
         xyNdh8SCxneT3DZK4GZXOvfUOVRhYhs8tJ+txbUgaanezxSI/isTI0RbqwpZuEGKMa8w
         RFaAJQk7ZWf7WAgpU6Tn1tgHxEHgjmCCPJuvCYG0S2fw81dLGdxqsQCqSHn7Q7ixTqMe
         DBVUvaoA7MxeR55vOTCyjK8819etiLgL1mPq2LEQ3SdnijDmc3wgAg/OVOuTS80Sb9D8
         bN5g==
X-Gm-Message-State: AFqh2kp8rZeuXYBATSlnEUvnr350HYLNgbDT+vAo5c+vJ9wLdPF3OS0E
        1BYE0BLNvZdX0Xm+iJZz7PN+IJ3HrbixtxPoFVoc2D1Gp5BoGs/0l6vMSJIBy+fJwMTkaHF7zdp
        rTAa87+2z9K66WmstqIsHkYsN
X-Received: by 2002:a05:600c:4e8d:b0:3dc:b0e:1e44 with SMTP id f13-20020a05600c4e8d00b003dc0b0e1e44mr11275486wmq.4.1674725352864;
        Thu, 26 Jan 2023 01:29:12 -0800 (PST)
X-Google-Smtp-Source: AMrXdXv4iuwtS6MVzNeCsO8laxeJMePaZ53o6qYn4WQWThNpjBtIStUKxwcRZto1e+4onhQznqLkkA==
X-Received: by 2002:a05:600c:4e8d:b0:3dc:b0e:1e44 with SMTP id f13-20020a05600c4e8d00b003dc0b0e1e44mr11275458wmq.4.1674725352592;
        Thu, 26 Jan 2023 01:29:12 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id j22-20020a05600c485600b003cffd3c3d6csm923358wmo.12.2023.01.26.01.29.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 01:29:12 -0800 (PST)
Message-ID: <db0c8f98-4bc1-a3ee-e173-7960830b1d3c@redhat.com>
Date:   Thu, 26 Jan 2023 10:29:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v10 6/8] block: Add BIO_PAGE_PINNED and associated
 infrastructure
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
 <20230125210657.2335748-7-dhowells@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230125210657.2335748-7-dhowells@redhat.com>
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
> Add BIO_PAGE_PINNED to indicate that the pages in a bio are pinned
> (FOLL_PIN) and that the pin will need removing.
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

