Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E8169E12B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 14:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbjBUNRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 08:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233049AbjBUNRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 08:17:40 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3904D28D0B;
        Tue, 21 Feb 2023 05:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676985458; x=1708521458;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=3eGz7N+2E+NaKCN7zEMJ4TPIqQxrgrt3fjv9tPx4ZyI=;
  b=AIevPF0KtIK0oiNwoghpzJBKp21seBhxOCeaxmjOcoWvJdpRr2gSzFez
   Yf2SvJsQf4X0w20DpgpASjErDb090Sv2Kpe7xJ//aKGE9hXQTZm9qJqbl
   JegXq2YuIbDwka1N4hYqlHA8HU5m7FjZxbmGTYUU+qkkog7poOgrmbyCZ
   E0XNbGxINgKh7cFQzqZHzHrf9UUOJiI7OHX7JVT0XGq+kLWo/gu7rY9Hj
   T9oWSIcp8g36tTZBnxdoFEoscix8PP/RccZixz8lvb63O+EeHYaXE26+t
   ehikoaOPVxdFNubaAhM6IhJYjplRizEa+IhUPphjxgQDF6kHkNWPvvZEk
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="331293828"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="331293828"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 05:17:37 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="795519001"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="795519001"
Received: from bpasca-mobl.ger.corp.intel.com ([10.249.40.37])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 05:17:34 -0800
Date:   Tue, 21 Feb 2023 15:17:32 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     David Laight <David.Laight@ACULAB.COM>
cc:     'Jiri Slaby' <jirislaby@kernel.org>,
        Mohammad Mahfooz <mohammadmahfoozpersonal@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        Alexander Vorwerk <alexander.vorwerk@stud.uni-goettingen.de>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: RE: [PATCH] serial: jsm: Use min_t instead of min
In-Reply-To: <f292a8314e334587979d1dc7edbf8085@AcuMS.aculab.com>
Message-ID: <26205580-7c9-685d-d8b7-6128cbe4f612@linux.intel.com>
References: <20230219205316.3499-1-mohammadmahfoozpersonal@gmail.com> <70ea8ee5-3f92-fe1c-c59d-74040bd1e610@kernel.org> <f292a8314e334587979d1dc7edbf8085@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Feb 2023, David Laight wrote:

> From: Jiri Slaby
> > Sent: 20 February 2023 11:52
> > 
> > On 19. 02. 23, 21:53, Mohammad Mahfooz wrote:
> > > Use min_t instead of min to cut down n further if needed.
> > >
> > > Signed-off-by: Mohammad Mahfooz <mohammadmahfoozpersonal@gmail.com>
> > > ---
> > >   drivers/tty/serial/jsm/jsm_neo.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/tty/serial/jsm/jsm_neo.c b/drivers/tty/serial/jsm/jsm_neo.c
> > > index 0c78f66276cd..4cce1e423b06 100644
> > > --- a/drivers/tty/serial/jsm/jsm_neo.c
> > > +++ b/drivers/tty/serial/jsm/jsm_neo.c
> > > @@ -350,7 +350,7 @@ static void neo_copy_data_from_uart_to_queue(struct jsm_channel *ch)
> > >   		 * IBM pSeries platform.
> > >   		 * 15 bytes max appears to be the magic number.
> > >   		 */
> > > -		n = min((u32) n, (u32) 12);
> > > +		n = min_t(u32, n, 12);
> > 
> > Nah, why is "n" signed in the first place? Could you fix that and all
> > all those casts in min()s around instead?
> 
> There is also a (IIRC) 'fifo_space -= 3;' in there that could
> also generate negatives.
> 
> I took one look at that function and ran away.

min_t() casts before compare so it would never work correctly if a 
negative number is fed into min_t(u32, ...).

Not that negative FIFO "space" makes any sense (and should be prevent 
at its source to begin with).

-- 
 i.

