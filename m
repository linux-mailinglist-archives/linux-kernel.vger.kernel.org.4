Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56FD7403BF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 21:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbjF0TD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 15:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbjF0TDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 15:03:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161F0122
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 12:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687892587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sCI/D1beeMuSDdc7buAbwdUV7v4DV3y3fmbUulZO5CA=;
        b=ikJzfkTJOd1F9vobjnDAkp0JT9yNC7CIG1xiY0nP5Kz2sGfxuEjePMQPq4T9H8ZDtbqdPN
        KeJJpzsllAE4IOAR+kw0L8q51fjjsWbBqfH9VEd225r1j/67Jswg33kWOn7BmxVjsGfMeR
        +znsUeVzF4+305TbP1+4cHNK+TazPN0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-6-ArLMsJJIOvWM1THfmZi-ew-1; Tue, 27 Jun 2023 15:03:04 -0400
X-MC-Unique: ArLMsJJIOvWM1THfmZi-ew-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C760328088B1;
        Tue, 27 Jun 2023 19:02:44 +0000 (UTC)
Received: from toolbox (unknown [10.2.17.15])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7AEBC200A3AD;
        Tue, 27 Jun 2023 19:02:42 +0000 (UTC)
Date:   Tue, 27 Jun 2023 12:02:40 -0700
From:   Chris Leech <cleech@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     netdev@vger.kernel.org,
        Alexander Duyck <alexander.duyck@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Mike Christie <michael.christie@oracle.com>,
        Lee Duncan <lduncan@suse.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Al Viro <viro@zeniv.linux.org.uk>, open-iscsi@googlegroups.com,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Subject: Re: [PATCH net-next v5 11/16] scsi: iscsi_tcp: Use
 sendmsg(MSG_SPLICE_PAGES) rather than sendpage
Message-ID: <ZJsyUK8DMN+P0nQo@toolbox>
References: <20230623225513.2732256-1-dhowells@redhat.com>
 <20230623225513.2732256-12-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623225513.2732256-12-dhowells@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 11:55:08PM +0100, David Howells wrote:
> Use sendmsg() with MSG_SPLICE_PAGES rather than sendpage.  This allows
> multiple pages and multipage folios to be passed through.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Mike Christie <michael.christie@oracle.com>
> cc: Lee Duncan <lduncan@suse.com>
> cc: Chris Leech <cleech@redhat.com>
> cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
> cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> cc: "David S. Miller" <davem@davemloft.net>
> cc: Eric Dumazet <edumazet@google.com>
> cc: Jakub Kicinski <kuba@kernel.org>
> cc: Paolo Abeni <pabeni@redhat.com>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: open-iscsi@googlegroups.com
> cc: linux-scsi@vger.kernel.org
> cc: target-devel@vger.kernel.org
> cc: netdev@vger.kernel.org
> ---
> 
> Notes:
>     ver #5)
>      - Split iscsi changes into client and target patches
> 
>  drivers/scsi/iscsi_tcp.c | 26 ++++++++++----------------
>  drivers/scsi/iscsi_tcp.h |  2 --
>  2 files changed, 10 insertions(+), 18 deletions(-)

This seems good to me.

Reviewed-by: Chris Leech <cleech@redhat.com>
 
> diff --git a/drivers/scsi/iscsi_tcp.c b/drivers/scsi/iscsi_tcp.c
> index 9637d4bc2bc9..9ab8555180a3 100644
> --- a/drivers/scsi/iscsi_tcp.c
> +++ b/drivers/scsi/iscsi_tcp.c
> @@ -301,35 +301,32 @@ static int iscsi_sw_tcp_xmit_segment(struct iscsi_tcp_conn *tcp_conn,
>  
>  	while (!iscsi_tcp_segment_done(tcp_conn, segment, 0, r)) {
>  		struct scatterlist *sg;
> +		struct msghdr msg = {};
> +		struct bio_vec bv;
>  		unsigned int offset, copy;
> -		int flags = 0;
>  
>  		r = 0;
>  		offset = segment->copied;
>  		copy = segment->size - offset;
>  
>  		if (segment->total_copied + segment->size < segment->total_size)
> -			flags |= MSG_MORE | MSG_SENDPAGE_NOTLAST;
> +			msg.msg_flags |= MSG_MORE;
>  
>  		if (tcp_sw_conn->queue_recv)
> -			flags |= MSG_DONTWAIT;
> +			msg.msg_flags |= MSG_DONTWAIT;
>  
> -		/* Use sendpage if we can; else fall back to sendmsg */
>  		if (!segment->data) {
> +			if (!tcp_conn->iscsi_conn->datadgst_en)
> +				msg.msg_flags |= MSG_SPLICE_PAGES;
>  			sg = segment->sg;
>  			offset += segment->sg_offset + sg->offset;
> -			r = tcp_sw_conn->sendpage(sk, sg_page(sg), offset,
> -						  copy, flags);
> +			bvec_set_page(&bv, sg_page(sg), copy, offset);
>  		} else {
> -			struct msghdr msg = { .msg_flags = flags };
> -			struct kvec iov = {
> -				.iov_base = segment->data + offset,
> -				.iov_len = copy
> -			};
> -
> -			r = kernel_sendmsg(sk, &msg, &iov, 1, copy);
> +			bvec_set_virt(&bv, segment->data + offset, copy);
>  		}
> +		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bv, 1, copy);
>  
> +		r = sock_sendmsg(sk, &msg);
>  		if (r < 0) {
>  			iscsi_tcp_segment_unmap(segment);
>  			return r;
> @@ -746,7 +743,6 @@ iscsi_sw_tcp_conn_bind(struct iscsi_cls_session *cls_session,
>  	sock_no_linger(sk);
>  
>  	iscsi_sw_tcp_conn_set_callbacks(conn);
> -	tcp_sw_conn->sendpage = tcp_sw_conn->sock->ops->sendpage;
>  	/*
>  	 * set receive state machine into initial state
>  	 */
> @@ -777,8 +773,6 @@ static int iscsi_sw_tcp_conn_set_param(struct iscsi_cls_conn *cls_conn,
>  			return -ENOTCONN;
>  		}
>  		iscsi_set_param(cls_conn, param, buf, buflen);
> -		tcp_sw_conn->sendpage = conn->datadgst_en ?
> -			sock_no_sendpage : tcp_sw_conn->sock->ops->sendpage;
>  		mutex_unlock(&tcp_sw_conn->sock_lock);
>  		break;
>  	case ISCSI_PARAM_MAX_R2T:
> diff --git a/drivers/scsi/iscsi_tcp.h b/drivers/scsi/iscsi_tcp.h
> index 68e14a344904..89a6fc552f0b 100644
> --- a/drivers/scsi/iscsi_tcp.h
> +++ b/drivers/scsi/iscsi_tcp.h
> @@ -47,8 +47,6 @@ struct iscsi_sw_tcp_conn {
>  	/* MIB custom statistics */
>  	uint32_t		sendpage_failures_cnt;
>  	uint32_t		discontiguous_hdr_cnt;
> -
> -	ssize_t (*sendpage)(struct socket *, struct page *, int, size_t, int);
>  };
>  
>  struct iscsi_sw_tcp_host {
> 

