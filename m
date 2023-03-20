Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1A96C21F7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 20:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjCTTw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 15:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjCTTwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 15:52:49 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C371ACE9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 12:52:42 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id qe8-20020a17090b4f8800b0023f07253a2cso13639159pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 12:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679341961;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OANc0wddnbWObPg1WIjsngMYc5gPIbvx0gC9JppESQk=;
        b=P3hxUHYnwFrcYrRWsgeprUnEMe8gM7vWq3kjfkBC/w3fC0+2t83Pj1mH+IGV1HzryC
         SjdCoZSzKzPCHWi81j7IikGp5bnuDaBd/4k2V5B36Y1FCYLAt4wOcAtbzsDOuzqZsHwd
         9QepYpaJ9TfJ8Fc0zSv+jPiwkoa0XB8oY3vN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679341961;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OANc0wddnbWObPg1WIjsngMYc5gPIbvx0gC9JppESQk=;
        b=s+CNj7hXkYukQno4dyG6SVgpbVwK0MIQDF4EiqrBj1zq5Zkos3XZDKiJvSRfj0kUO/
         9CgOtmqOc4Ee7MUDfmXhUGoYZGkYoXNRcDbYoMjJVA/+GJ0cHGqXkgBquSEv8HaiRP0E
         kuLw2A2MlywhYp1nosh6v0dQeQ/jlEYDQdKhaQa0KJ0036SZcbKw33prJ/bjpZlUVGFi
         yQyDopDmv7dNZzLMlf612SDZuIud6MRZyXrTZB3KeLB8AG+shAcYUtqkNyb0B33XeLlE
         0qU0ELcZKMq93omLVS5G2DGbJpb24+90FPI1tOPxQFaoDjkvO7GXpJcdG2GtTUfgYjBU
         btgg==
X-Gm-Message-State: AO0yUKUj1HrMa/aqTgtb8SN/IC2iSiyf9db+CM3tqAdFzspljD8yl5Hs
        wcND8Lab6lu5qyB9ndd6MW4veA==
X-Google-Smtp-Source: AK7set8PpnnGVghBCtjPCNtVCtxa8xBN7JiVeZFbL8yfnBFI/Vq6y0nlBsYmDSleIsZfo26fgmhYwA==
X-Received: by 2002:a17:902:e0d3:b0:19f:1e3e:a84d with SMTP id e19-20020a170902e0d300b0019f1e3ea84dmr13488186pla.64.1679341961143;
        Mon, 20 Mar 2023 12:52:41 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w3-20020a170902d70300b0019f0e766809sm7119986ply.306.2023.03.20.12.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 12:52:40 -0700 (PDT)
Message-ID: <6418b988.170a0220.82efc.cadd@mx.google.com>
X-Google-Original-Message-ID: <202303201245.@keescook>
Date:   Mon, 20 Mar 2023 12:52:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Gregory Greenman <gregory.greenman@intel.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Benjamin Berg <benjamin.berg@intel.com>,
        Sriram R <quic_srirrama@quicinc.com>,
        lukasz.wojnilowicz@gmail.com, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] wifi: iwlwifi: dvm: Add struct_group for struct
 iwl_keyinfo keys
References: <20230218191056.never.374-kees@kernel.org>
 <3181a89b49e571883525172a7773b12f046e8b09.camel@sipsolutions.net>
 <641897bd.630a0220.174d9.9d11@mx.google.com>
 <0ec5fe8b6945ee545b335ef2f3bee75b0af458d0.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ec5fe8b6945ee545b335ef2f3bee75b0af458d0.camel@sipsolutions.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 07:34:59PM +0100, Johannes Berg wrote:
> > > 
> > > >  	case WLAN_CIPHER_SUITE_TKIP:
> > > >  		key_flags |= STA_KEY_FLG_TKIP;
> > > >  		sta_cmd.key.tkip_rx_tsc_byte2 = tkip_iv32;
> > > >  		for (i = 0; i < 5; i++)
> > > >  			sta_cmd.key.tkip_rx_ttak[i] = cpu_to_le16(tkip_p1k[i]);
> > > > -		memcpy(sta_cmd.key.key, keyconf->key, keyconf->keylen);
> > > > +		memcpy(&sta_cmd.key.keys, keyconf->key, keyconf->keylen);
> > > 
> > > And that's actually a bug, we should've copied only 16 bytes, I guess.
> > > DVM didn't support MIC offload anyway (at least the way Linux uses the
> > > firmware, though I thought it doesn't at all), so we don't need the MIC
> > > RX/TX keys in there, but anyway the sequence counter values are not part
> > > of the key material on the host.
> > > 
> > > I don't think I have a machine now to test this with (nor a TKIP AP, of
> > > course, but that could be changed) - but I suspect that since we
> > > actually calculate the TTAK above, we might not even need this memcpy()
> > > at all?
> > 
> > It's the latter that is triggered in the real world, though. See the
> > referenced URL and also now on bugzilla:
> > https://bugzilla.kernel.org/show_bug.cgi?id=217214
> > i.e.: drivers/net/wireless/intel/iwlwifi/dvm/sta.c:1103
> > 
> > So keyconf->keylen is coming in as 32. If this is a bug, I'm not sure
> > where/how to fix it.
> 
> Yes, I know it's coming in as such - I believe it should be copying 16
> bytes instead of the full keylen. TKIP keys are comprised of 16 bytes
> encryption/decryption key and 8 bytes TX/RX MIC keys for a total of 32,
> but since the device doesn't do MIC calculations, it only needs the
> first 16 bytes here (if even that, since we also give it the P1K which
> is derived from the TK...? maybe not even that)
> 
> But I guess we should test it ... not sure I still have a machine that
> takes these NICs (I do have NICs).

What sort of patch would you like here? How should the other cases in
the switch statement behave?

Are these the correct bounds?

	WLAN_CIPHER_SUITE_CCMP:   keylen <= 16
	WLAN_CIPHER_SUITE_TKIP:   keylen <= 16
	WLAN_CIPHER_SUITE_WEP104: keylen <= 13
	WLAN_CIPHER_SUITE_WEP40:  keylen <= 13

and should it silently ignore larger values in each case?

-- 
Kees Cook
