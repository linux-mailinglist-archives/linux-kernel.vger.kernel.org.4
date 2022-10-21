Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B819D6075FF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 13:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbiJULVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 07:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbiJULVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 07:21:00 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1722514E1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 04:20:58 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 3-20020a17090a0f8300b00212d5cd4e5eso709799pjz.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 04:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PVxrbdloPyeC7I/bClCHPaphZOmS62WhGrOJR/1SEx0=;
        b=MyJKtJ/ZCHJdYsCn2j64p5BmT6QyI5frJjqts7FvsQSznMxcSspaLyESPqEOHYiyfN
         0gcY0cQ1CZCbz/CRw53i9ur6YO1StEHMH4daMsTL9kRYb+H7zVgRiucjG2gpoHvAeoZN
         8r/kATvwxpzdya4feBBsqjztLWSacMdF9SahGB1HlLlDm/JMR8tP5onZ9qoNmMlxZCpV
         aZXeJfPlhvwUt1QKoJVLwcpgRG1mccvv6+8fjroaoIlwADYcwELV9TGGx8kh4L15cFJH
         qYH7luxxGN/1hvb5XksLYjpflCsCwFCcei/xNneMaOMJqKGvixfZYFcIxI71FXdCNNJd
         Eb/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVxrbdloPyeC7I/bClCHPaphZOmS62WhGrOJR/1SEx0=;
        b=kFTL4lJQGjA6+woVdmZg18+xfWT1XalCUJ9NA/GeK87SDVFY1E5CSbRtcviSbRmV8y
         JVGcNNnL2CF6r8JTF12pWkUo/nvPgVm3APXsgk5l4LPH5X3M5XipKBMgo/iQUVokKaBJ
         NgIEf0igv8Mj39gKBHA0trL30vsIxuy06X1QQbc526CQEasPIBwQywPvmXLpb5pXRpBU
         e0TrcDlKjQjz2zot3dToC/rlPVgIiwKzBSwsUPBF257/vFkzhDZ8afwYPvzYDPh1EbGa
         tvDEo8KFy6XtXT/sD6C3JM8kuuLKDQIxJ2Dg5cngajNtsZi7yS44CzvozgMv9SU6XJd+
         12Ww==
X-Gm-Message-State: ACrzQf03Uwz2c7z6USb2XTYlLS0IB+pGM4ygl/XJrOJbv1P/JM1YjubQ
        8sH4tBIRvm8bXxhz6AyujH6Tc0eLu1M6/XCn
X-Google-Smtp-Source: AMsMyM7f6OAkLIejzpa1Mw+h4+S7hXcJYNWXrgn44dgnez1Vgxyg0/EY/g/eVmZkfbWeQoUOq9uoDA==
X-Received: by 2002:a17:90b:3d1:b0:212:732d:a1c8 with SMTP id go17-20020a17090b03d100b00212732da1c8mr8188889pjb.189.1666351257756;
        Fri, 21 Oct 2022 04:20:57 -0700 (PDT)
Received: from jacob-Ubuntu (126.224.215.218.sta.wbroadband.net.au. [218.215.224.126])
        by smtp.gmail.com with ESMTPSA id t16-20020a170902e85000b00179eaf275d5sm14711612plg.27.2022.10.21.04.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 04:20:57 -0700 (PDT)
Date:   Fri, 21 Oct 2022 22:20:52 +1100
From:   Jacob Bai <jacob.bai.au@gmail.com>
To:     Joe Perches <joe@perches.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: replace IEs with ies
Message-ID: <Y1KAlCIt64/y/PE7@jacob-Ubuntu>
References: <20221018105409.18331-1-jacob.bai.au@gmail.com>
 <8617109bdc3e192b98e5c3b21ba871501a87f6d9.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8617109bdc3e192b98e5c3b21ba871501a87f6d9.camel@perches.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 09:35:32PM -0700, Joe Perches wrote:
> On Tue, 2022-10-18 at 21:54 +1100, Jacob Bai wrote:
> > Replace wlan_bssid_ex struct member IEs to ies.
> > CamelCase issue found by checkpatch.
> 
> Please try to avoid changing code merely to appease checkpatch.
> 
> What is the value of the last s?
> When is a specific index of the IEs array actually used?
> 
> Mere renaming may be removing useful markings.
> 
> (removing a lot of the rename blocks)
> 
Thanks for those advices. As this was my first patch, I tried to 
pick up an easier one to start with and followed commit 341f27d0
but changed "IEs" only. 
> > diff --git a/drivers/staging/r8188eu/include/wlan_bssdef.h b/drivers/staging/r8188eu/include/wlan_bssdef.h
> []
> > @@ -239,7 +239,7 @@ struct wlan_bssid_ex {
> >  	unsigned char SupportedRates[NDIS_802_11_LENGTH_RATES_EX];
> >  	struct wlan_phy_info	PhyInfo;
> >  	u32  IELength;
> > -	u8  IEs[MAX_IE_SZ];	/* timestamp, beacon interval, and
> > +	u8  ies[MAX_IE_SZ];	/* timestamp, beacon interval, and
> >  				 * capability information) */
> >  } __packed;
> []
> > diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> []
> > @@ -104,11 +104,11 @@ static char *translate_scan(struct adapter *padapter,
> >  
> >  			if (pnetwork->network.Reserved[0] == 2) {/*  Probe Request */
> >  				/*	Verifying the P2P IE */
> > -				if (rtw_get_p2p_ie(pnetwork->network.IEs, pnetwork->network.IELength, NULL, &p2pielen))
> > +				if (rtw_get_p2p_ie(pnetwork->network.ies, pnetwork->network.IELength, NULL, &p2pielen))
> >  					blnGotP2PIE = true;
> >  			} else {/*  Beacon or Probe Respones */
> >  				/*	Verifying the P2P IE */
> > -				if (rtw_get_p2p_ie(&pnetwork->network.IEs[12], pnetwork->network.IELength - 12, NULL, &p2pielen))
> > +				if (rtw_get_p2p_ie(&pnetwork->network.ies[12], pnetwork->network.IELength - 12, NULL, &p2pielen))
> 
> For instance, these consistent 12 and "- 12" uses may be better as some
> alternate array.
Could you please be more detail on this?
> 
> >  					blnGotP2PIE = true;
> >  			}
> >  		}
> > @@ -131,7 +131,7 @@ static char *translate_scan(struct adapter *padapter,
> >  	start = iwe_stream_add_point(info, start, stop, &iwe, pnetwork->network.Ssid.Ssid);
> >  
> >  	/* parsing HT_CAP_IE */
> > -	p = rtw_get_ie(&pnetwork->network.IEs[12], _HT_CAPABILITY_IE_, &ht_ielen, pnetwork->network.IELength - 12);
> > +	p = rtw_get_ie(&pnetwork->network.ies[12], _HT_CAPABILITY_IE_, &ht_ielen, pnetwork->network.IELength - 12);
> >  
> >  	if (p && ht_ielen > 0) {
> >  		struct ieee80211_ht_cap *pht_capie;
> 
> etc...
> 
> Also this may be removing similarities between a few other realtek
> staging drivers
> 
> $ git grep  "\[MAX_IE_SZ\]"
> drivers/staging/r8188eu/include/wlan_bssdef.h:  u8  IEs[MAX_IE_SZ];     /* timestamp, beacon interval, and
> drivers/staging/rtl8712/wlan_bssdef.h:  u8 IEs[MAX_IE_SZ];
> drivers/staging/rtl8723bs/include/wlan_bssdef.h:        u8  ies[MAX_IE_SZ];     /* timestamp, beacon interval, and capability information) */
> 
looks like rtl8723bs has already been updated with ies, should I replace
IELength as well like the commit I followed?
