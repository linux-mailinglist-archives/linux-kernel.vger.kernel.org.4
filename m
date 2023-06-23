Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2401B73C133
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 22:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbjFWUsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 16:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjFWUrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 16:47:31 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240D2269F;
        Fri, 23 Jun 2023 13:46:09 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-25eb3db3004so581765a91.0;
        Fri, 23 Jun 2023 13:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687553166; x=1690145166;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MqtXAI+GLLnmMoFplI8FBOa7S4md/3B3tS2XXiqiaPc=;
        b=IWLoPaiByeeVz95pFswuN4iG50HcJHGbYYCRZUwJ48ZZ7+mFKLqj0IlX6r3/sG39D+
         cw9Qawl/KAuFBSowgsFamwBkHyEWWAzbpsvBtJSesyZjuxieX/+yOmRquRNGA2dgT/Wh
         TR9Zh+zS14ugiORsm7RDmm4q9/HHLQ9coq2gPZDC+hz+dPCKw8gVdql0O5G21qEXZEPm
         e8EyIMUQVkkp1Knsn+eWPwCctn63t0YL/mwoduRvF2k1GFU/EOjMdjnaRrvO7wmXph8G
         481e4/VP6BH2qdFoKTsKwd0NGngd/m0d4OcOOTn8pD2a4zmVHwgF9q8xUDr1fEq1vOOj
         unjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687553166; x=1690145166;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MqtXAI+GLLnmMoFplI8FBOa7S4md/3B3tS2XXiqiaPc=;
        b=ltKBVTtkVcEXApk/BvXvXmApOHPp3spBRupQX4HMO19nwadzPQxKyfYk4ull6RVyUG
         H6+ZvbYir8bbgq3tGKHIOawpMuvuQ5AwY45DYug+ThiYp9oJ0kK4G1aK+H8EiJfWOdCY
         xx1lgCXKxtJJvPj2BXpptRRZTs//GvVezyfrvhLRMgidNNWDEkAarpWmh1ic1I52CsQk
         rlsmdggG7Ai8R9nsKkdOUnwA+fVWUAd0UPYyWeOfbrI1wsph/PV7CsUwmOKR6EhfRfBi
         4GHSAm/4XYnO5HnuCEQBYiSXfiTpqSrXvZpp3c43rb9pQjbUGBEEIxYO/eoKK8ACmDiG
         FdUg==
X-Gm-Message-State: AC+VfDzGjh5BeRF/EZFr3xAJ2E/7TkRe6qG838qObVbxfWMk3kXm6FxS
        3+crFTzxQkgvtWGJLfPTD7A=
X-Google-Smtp-Source: ACHHUZ4/Pc655NL2Fp6bHunoF7dUR87TDP+T/gP/n+JQCxoHIkKqbBoVCpZ03aiZjWHUKLYEUoalQw==
X-Received: by 2002:a17:90a:d583:b0:262:c414:e0af with SMTP id v3-20020a17090ad58300b00262c414e0afmr240306pju.31.1687553166226;
        Fri, 23 Jun 2023 13:46:06 -0700 (PDT)
Received: from localhost (ec2-54-67-115-33.us-west-1.compute.amazonaws.com. [54.67.115.33])
        by smtp.gmail.com with ESMTPSA id 19-20020a17090a1a1300b0023fcece8067sm155310pjk.2.2023.06.23.13.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 13:46:05 -0700 (PDT)
Date:   Fri, 23 Jun 2023 02:59:23 +0000
From:   Bobby Eshleman <bobbyeshleman@gmail.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     Bobby Eshleman <bobby.eshleman@bytedance.com>,
        linux-hyperv@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Simon Horman <simon.horman@corigine.com>,
        virtualization@lists.linux-foundation.org,
        Eric Dumazet <edumazet@google.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bryan Tan <bryantan@vmware.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Krasnov Arseniy <oxffffaa@gmail.com>,
        Vishnu Dasa <vdasa@vmware.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH RFC net-next v4 3/8] vsock: support multi-transport
 datagrams
Message-ID: <ZJUKi+NtOajbplQg@bullseye>
References: <20230413-b4-vsock-dgram-v4-0-0cebbb2ae899@bytedance.com>
 <20230413-b4-vsock-dgram-v4-3-0cebbb2ae899@bytedance.com>
 <tngyeva5by3aldrhlixajjin2hqmcl6uruvuoed7hyrndlesfd@bbv7aphqye2q>
 <ZJUIWcgg13F7DNBm@bullseye>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJUIWcgg13F7DNBm@bullseye>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 02:50:01AM +0000, Bobby Eshleman wrote:
> On Thu, Jun 22, 2023 at 05:19:08PM +0200, Stefano Garzarella wrote:
> > On Sat, Jun 10, 2023 at 12:58:30AM +0000, Bobby Eshleman wrote:
> > > This patch adds support for multi-transport datagrams.
> > > 
> > > This includes:
> > > - Per-packet lookup of transports when using sendto(sockaddr_vm)
> > > - Selecting H2G or G2H transport using VMADDR_FLAG_TO_HOST and CID in
> > >  sockaddr_vm
> > > 
> > > To preserve backwards compatibility with VMCI, some important changes
> > > were made. The "transport_dgram" / VSOCK_TRANSPORT_F_DGRAM is changed to
> > > be used for dgrams iff there is not yet a g2h or h2g transport that has
> > 
> > s/iff/if
> > 
> > > been registered that can transmit the packet. If there is a g2h/h2g
> > > transport for that remote address, then that transport will be used and
> > > not "transport_dgram". This essentially makes "transport_dgram" a
> > > fallback transport for when h2g/g2h has not yet gone online, which
> > > appears to be the exact use case for VMCI.
> > > 
> > > This design makes sense, because there is no reason that the
> > > transport_{g2h,h2g} cannot also service datagrams, which makes the role
> > > of transport_dgram difficult to understand outside of the VMCI context.
> > > 
> > > The logic around "transport_dgram" had to be retained to prevent
> > > breaking VMCI:
> > > 
> > > 1) VMCI datagrams appear to function outside of the h2g/g2h
> > >   paradigm. When the vmci transport becomes online, it registers itself
> > >   with the DGRAM feature, but not H2G/G2H. Only later when the
> > >   transport has more information about its environment does it register
> > >   H2G or G2H. In the case that a datagram socket becomes active
> > >   after DGRAM registration but before G2H/H2G registration, the
> > >   "transport_dgram" transport needs to be used.
> > 
> > IIRC we did this, because at that time only VMCI supported DGRAM. Now that
> > there are more transports, maybe DGRAM can follow the h2g/g2h paradigm.
> > 
> 
> Totally makes sense. I'll add the detail above that the prior design was
> a result of chronology.
> 
> > > 
> > > 2) VMCI seems to require special message be sent by the transport when a
> > >   datagram socket calls bind(). Under the h2g/g2h model, the transport
> > >   is selected using the remote_addr which is set by connect(). At
> > >   bind time there is no remote_addr because often no connect() has been
> > >   called yet: the transport is null. Therefore, with a null transport
> > >   there doesn't seem to be any good way for a datagram socket a tell the
> > >   VMCI transport that it has just had bind() called upon it.
> > 
> > @Vishnu, @Bryan do you think we can avoid this in some way?
> > 
> > > 
> > > Only transports with a special datagram fallback use-case such as VMCI
> > > need to register VSOCK_TRANSPORT_F_DGRAM.
> > 
> > Maybe we should rename it in VSOCK_TRANSPORT_F_DGRAM_FALLBACK or
> > something like that.
> > 
> > In any case, we definitely need to update the comment in
> > include/net/af_vsock.h on top of VSOCK_TRANSPORT_F_DGRAM mentioning
> > this.
> > 
> 
> Agreed. I'll rename to VSOCK_TRANSPORT_F_DGRAM_FALLBACK, unless we find
> there is a better way altogether.
> 
> > > 
> > > Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
> > > ---
> > > drivers/vhost/vsock.c                   |  1 -
> > > include/linux/virtio_vsock.h            |  2 -
> > > net/vmw_vsock/af_vsock.c                | 78 +++++++++++++++++++++++++--------
> > > net/vmw_vsock/hyperv_transport.c        |  6 ---
> > > net/vmw_vsock/virtio_transport.c        |  1 -
> > > net/vmw_vsock/virtio_transport_common.c |  7 ---
> > > net/vmw_vsock/vsock_loopback.c          |  1 -
> > > 7 files changed, 60 insertions(+), 36 deletions(-)
> > > 
> > > diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> > > index c8201c070b4b..8f0082da5e70 100644
> > > --- a/drivers/vhost/vsock.c
> > > +++ b/drivers/vhost/vsock.c
> > > @@ -410,7 +410,6 @@ static struct virtio_transport vhost_transport = {
> > > 		.cancel_pkt               = vhost_transport_cancel_pkt,
> > > 
> > > 		.dgram_enqueue            = virtio_transport_dgram_enqueue,
> > > -		.dgram_bind               = virtio_transport_dgram_bind,
> > > 		.dgram_allow              = virtio_transport_dgram_allow,
> > > 		.dgram_get_cid		  = virtio_transport_dgram_get_cid,
> > > 		.dgram_get_port		  = virtio_transport_dgram_get_port,
> > > diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> > > index 23521a318cf0..73afa09f4585 100644
> > > --- a/include/linux/virtio_vsock.h
> > > +++ b/include/linux/virtio_vsock.h
> > > @@ -216,8 +216,6 @@ void virtio_transport_notify_buffer_size(struct vsock_sock *vsk, u64 *val);
> > > u64 virtio_transport_stream_rcvhiwat(struct vsock_sock *vsk);
> > > bool virtio_transport_stream_is_active(struct vsock_sock *vsk);
> > > bool virtio_transport_stream_allow(u32 cid, u32 port);
> > > -int virtio_transport_dgram_bind(struct vsock_sock *vsk,
> > > -				struct sockaddr_vm *addr);
> > > bool virtio_transport_dgram_allow(u32 cid, u32 port);
> > > int virtio_transport_dgram_get_cid(struct sk_buff *skb, unsigned int *cid);
> > > int virtio_transport_dgram_get_port(struct sk_buff *skb, unsigned int *port);
> > > diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> > > index 74358f0b47fa..ef86765f3765 100644
> > > --- a/net/vmw_vsock/af_vsock.c
> > > +++ b/net/vmw_vsock/af_vsock.c
> > > @@ -438,6 +438,18 @@ vsock_connectible_lookup_transport(unsigned int cid, __u8 flags)
> > > 	return transport;
> > > }
> > > 
> > > +static const struct vsock_transport *
> > > +vsock_dgram_lookup_transport(unsigned int cid, __u8 flags)
> > > +{
> > > +	const struct vsock_transport *transport;
> > > +
> > > +	transport = vsock_connectible_lookup_transport(cid, flags);
> > > +	if (transport)
> > > +		return transport;
> > > +
> > > +	return transport_dgram;
> > > +}
> > > +
> > > /* Assign a transport to a socket and call the .init transport callback.
> > >  *
> > >  * Note: for connection oriented socket this must be called when vsk->remote_addr
> > > @@ -474,7 +486,8 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
> > > 
> > > 	switch (sk->sk_type) {
> > > 	case SOCK_DGRAM:
> > > -		new_transport = transport_dgram;
> > > +		new_transport = vsock_dgram_lookup_transport(remote_cid,
> > > +							     remote_flags);
> > > 		break;
> > > 	case SOCK_STREAM:
> > > 	case SOCK_SEQPACKET:
> > > @@ -691,6 +704,9 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
> > > static int __vsock_bind_dgram(struct vsock_sock *vsk,
> > > 			      struct sockaddr_vm *addr)
> > > {
> > > +	if (!vsk->transport || !vsk->transport->dgram_bind)
> > > +		return -EINVAL;
> > > +
> > > 	return vsk->transport->dgram_bind(vsk, addr);
> > > }
> > > 
> > > @@ -1172,19 +1188,24 @@ static int vsock_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
> > > 
> > > 	lock_sock(sk);
> > > 
> > > -	transport = vsk->transport;
> > > -
> > > -	err = vsock_auto_bind(vsk);
> > > -	if (err)
> > > -		goto out;
> > > -
> > > -
> > > 	/* If the provided message contains an address, use that.  Otherwise
> > > 	 * fall back on the socket's remote handle (if it has been connected).
> > > 	 */
> > > 	if (msg->msg_name &&
> > > 	    vsock_addr_cast(msg->msg_name, msg->msg_namelen,
> > > 			    &remote_addr) == 0) {
> > > +		transport = vsock_dgram_lookup_transport(remote_addr->svm_cid,
> > > +							 remote_addr->svm_flags);
> > > +		if (!transport) {
> > > +			err = -EINVAL;
> > > +			goto out;
> > > +		}
> > > +
> > > +		if (!try_module_get(transport->module)) {
> > > +			err = -ENODEV;
> > > +			goto out;
> > > +		}
> > > +
> > > 		/* Ensure this address is of the right type and is a valid
> > > 		 * destination.
> > > 		 */
> > > @@ -1193,11 +1214,27 @@ static int vsock_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
> > > 			remote_addr->svm_cid = transport->get_local_cid();
> > > 
> > 
> > From here ...
> > 
> > > 		if (!vsock_addr_bound(remote_addr)) {
> > > +			module_put(transport->module);
> > > +			err = -EINVAL;
> > > +			goto out;
> > > +		}
> > > +
> > > +		if (!transport->dgram_allow(remote_addr->svm_cid,
> > > +					    remote_addr->svm_port)) {
> > > +			module_put(transport->module);
> > > 			err = -EINVAL;
> > > 			goto out;
> > > 		}
> > > +
> > > +		err = transport->dgram_enqueue(vsk, remote_addr, msg, len);
> > 
> > ... to here, looks like duplicate code, can we get it out of the if block?
> > 
> 
> Yes, I think using something like this:
> 
> [...]
> 	bool module_got = false;
> 
> [...]
> 		if (!try_module_get(transport->module)) {
> 			err = -ENODEV;
> 			goto out;
> 		}
> 		module_got = true;
> 
> [...]
> 
> out:
> 	if (likely(transport && !err && module_got))

Actually, just...

	if (module_got)

> 		module_put(transport->module)
> 
> > > +		module_put(transport->module);
> > > 	} else if (sock->state == SS_CONNECTED) {
> > > 		remote_addr = &vsk->remote_addr;
> > > +		transport = vsk->transport;
> > > +
> > > +		err = vsock_auto_bind(vsk);
> > > +		if (err)
> > > +			goto out;
> > > 
> > > 		if (remote_addr->svm_cid == VMADDR_CID_ANY)
> > > 			remote_addr->svm_cid = transport->get_local_cid();
> > > @@ -1205,23 +1242,23 @@ static int vsock_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
> > > 		/* XXX Should connect() or this function ensure remote_addr is
> > > 		 * bound?
> > > 		 */
> > > -		if (!vsock_addr_bound(&vsk->remote_addr)) {
> > > +		if (!vsock_addr_bound(remote_addr)) {
> > > 			err = -EINVAL;
> > > 			goto out;
> > > 		}
> > > -	} else {
> > > -		err = -EINVAL;
> > > -		goto out;
> > > -	}
> > > 
> > > -	if (!transport->dgram_allow(remote_addr->svm_cid,
> > > -				    remote_addr->svm_port)) {
> > > +		if (!transport->dgram_allow(remote_addr->svm_cid,
> > > +					    remote_addr->svm_port)) {
> > > +			err = -EINVAL;
> > > +			goto out;
> > > +		}
> > > +
> > > +		err = transport->dgram_enqueue(vsk, remote_addr, msg, len);
> > > +	} else {
> > > 		err = -EINVAL;
> > > 		goto out;
> > > 	}
> > > 
> > > -	err = transport->dgram_enqueue(vsk, remote_addr, msg, len);
> > > -
> > > out:
> > > 	release_sock(sk);
> > > 	return err;
> > > @@ -1255,13 +1292,18 @@ static int vsock_dgram_connect(struct socket *sock,
> > > 	if (err)
> > > 		goto out;
> > > 
> > > +	memcpy(&vsk->remote_addr, remote_addr, sizeof(vsk->remote_addr));
> > > +
> > > +	err = vsock_assign_transport(vsk, NULL);
> > > +	if (err)
> > > +		goto out;
> > > +
> > > 	if (!vsk->transport->dgram_allow(remote_addr->svm_cid,
> > > 					 remote_addr->svm_port)) {
> > > 		err = -EINVAL;
> > > 		goto out;
> > > 	}
> > > 
> > > -	memcpy(&vsk->remote_addr, remote_addr, sizeof(vsk->remote_addr));
> > > 	sock->state = SS_CONNECTED;
> > > 
> > > 	/* sock map disallows redirection of non-TCP sockets with sk_state !=
> > > diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
> > > index ff6e87e25fa0..c00bc5da769a 100644
> > > --- a/net/vmw_vsock/hyperv_transport.c
> > > +++ b/net/vmw_vsock/hyperv_transport.c
> > > @@ -551,11 +551,6 @@ static void hvs_destruct(struct vsock_sock *vsk)
> > > 	kfree(hvs);
> > > }
> > > 
> > > -static int hvs_dgram_bind(struct vsock_sock *vsk, struct sockaddr_vm *addr)
> > > -{
> > > -	return -EOPNOTSUPP;
> > > -}
> > > -
> > > static int hvs_dgram_get_cid(struct sk_buff *skb, unsigned int *cid)
> > > {
> > > 	return -EOPNOTSUPP;
> > > @@ -841,7 +836,6 @@ static struct vsock_transport hvs_transport = {
> > > 	.connect                  = hvs_connect,
> > > 	.shutdown                 = hvs_shutdown,
> > > 
> > > -	.dgram_bind               = hvs_dgram_bind,
> > > 	.dgram_get_cid		  = hvs_dgram_get_cid,
> > > 	.dgram_get_port		  = hvs_dgram_get_port,
> > > 	.dgram_get_length	  = hvs_dgram_get_length,
> > > diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> > > index 5763cdf13804..1b7843a7779a 100644
> > > --- a/net/vmw_vsock/virtio_transport.c
> > > +++ b/net/vmw_vsock/virtio_transport.c
> > > @@ -428,7 +428,6 @@ static struct virtio_transport virtio_transport = {
> > > 		.shutdown                 = virtio_transport_shutdown,
> > > 		.cancel_pkt               = virtio_transport_cancel_pkt,
> > > 
> > > -		.dgram_bind               = virtio_transport_dgram_bind,
> > > 		.dgram_enqueue            = virtio_transport_dgram_enqueue,
> > > 		.dgram_allow              = virtio_transport_dgram_allow,
> > > 		.dgram_get_cid		  = virtio_transport_dgram_get_cid,
> > > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > > index e6903c719964..d5a3c8efe84b 100644
> > > --- a/net/vmw_vsock/virtio_transport_common.c
> > > +++ b/net/vmw_vsock/virtio_transport_common.c
> > > @@ -790,13 +790,6 @@ bool virtio_transport_stream_allow(u32 cid, u32 port)
> > > }
> > > EXPORT_SYMBOL_GPL(virtio_transport_stream_allow);
> > > 
> > > -int virtio_transport_dgram_bind(struct vsock_sock *vsk,
> > > -				struct sockaddr_vm *addr)
> > > -{
> > > -	return -EOPNOTSUPP;
> > > -}
> > > -EXPORT_SYMBOL_GPL(virtio_transport_dgram_bind);
> > > -
> > > int virtio_transport_dgram_get_cid(struct sk_buff *skb, unsigned int *cid)
> > > {
> > > 	return -EOPNOTSUPP;
> > > diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
> > > index 2f3cabc79ee5..e9de45a26fbd 100644
> > > --- a/net/vmw_vsock/vsock_loopback.c
> > > +++ b/net/vmw_vsock/vsock_loopback.c
> > > @@ -61,7 +61,6 @@ static struct virtio_transport loopback_transport = {
> > > 		.shutdown                 = virtio_transport_shutdown,
> > > 		.cancel_pkt               = vsock_loopback_cancel_pkt,
> > > 
> > > -		.dgram_bind               = virtio_transport_dgram_bind,
> > > 		.dgram_enqueue            = virtio_transport_dgram_enqueue,
> > > 		.dgram_allow              = virtio_transport_dgram_allow,
> > > 		.dgram_get_cid		  = virtio_transport_dgram_get_cid,
> > > 
> > > -- 
> > > 2.30.2
> > > 
> > 
> > The rest LGTM!
> > 
> > Stefano
> 
> Thanks,
> Bobby
