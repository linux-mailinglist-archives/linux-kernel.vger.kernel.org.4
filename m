Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC71668DFD7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 19:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbjBGSWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 13:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbjBGSVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 13:21:38 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3994B2128
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 10:21:07 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id x8so11212102ybt.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 10:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YgtQzTnRbIYg38jJchN06SmvlnyEwUuCcDS5MUriAcg=;
        b=qQejTzWm3ZVkyedm+qpn7sKhWB05HsE5Bz9mysMH6HhhYsjzo2052XmSD2dIYGBXAy
         L5qIZyP6Edzx543kT8tWteEF2mrY4Rp1OrIvNq+1tyKH+L0K8U5Kj2iqTXE2XEzfI1lD
         gly0qJ0z99TJsKks7YQ/0gFE/5O+Rn5qz0hbyhiUOkOj7xa3gXFHzK20VBPrk0zrjWvW
         yv/DC1HGGzFmWfz2eBpAIrsg3KctA/vmSQaQdWpfD4JRNE9WsaNMqj176R9IRppIASrX
         c2Ps7vXHTBYADlw65xo7BtVleIvH908+/WH5d5bH8AJ2FzRIDtaw074bb+Qi5DmdtuQ+
         StAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YgtQzTnRbIYg38jJchN06SmvlnyEwUuCcDS5MUriAcg=;
        b=BOnJKB/YwvghP7bjhFyveJNoCVlyPrK8pbJKd3lbANmFM5W1dk2wRhJTQ4OgPeuEFi
         Tfo/0cpTTM0eAe3QfYcOW1egOcz8uJ92q7CDM07WSpalbltXME8kEbkLh8ZoqAGNZOoh
         Cl+layP/dqhCTd4gR68p1Xx88kgl/tG5gCr9YY9++6LUMCRSuF3hWaxPOX/EV8D3WVTJ
         e4H9I5yxggzYssZemaWkcGdZ1+Hx3Cxm/1zYv0Xqp5cD412QD9NjtauxM+Ay3YZYBgs8
         6VzmX8XnAEeUoKLWCvjJAilrlNme/w4A0LPuDRrmpw06f147wGJ7Twzo1kOz+cWHZOcI
         Htuw==
X-Gm-Message-State: AO0yUKW2Lpncr3C9IkrXrOndTYmjMKVHDuDrBnr8gVdruwUP0eWK2uLr
        cimveB3uZfkt470/EMxMI52xusrk+eBAJRWMp/n+mw==
X-Google-Smtp-Source: AK7set+jm1zYINS+NliZlMfuV08OLGvpAfypwpp1JL58OQi8bfPIKpRIbpDKObv3qmyUwnguDZw2Ke9C3lVmKu54ZG0=
X-Received: by 2002:a25:d3c3:0:b0:8a1:2e92:c089 with SMTP id
 e186-20020a25d3c3000000b008a12e92c089mr685041ybf.186.1675794066368; Tue, 07
 Feb 2023 10:21:06 -0800 (PST)
MIME-Version: 1.0
References: <20230202-rds-zerocopy-v2-1-c999755075db@diag.uniroma1.it>
In-Reply-To: <20230202-rds-zerocopy-v2-1-c999755075db@diag.uniroma1.it>
From:   Willem de Bruijn <willemb@google.com>
Date:   Tue, 7 Feb 2023 13:20:29 -0500
Message-ID: <CA+FuTSftbF=xwWd_kJHuJ9hQ3PYFOT48r_TazEDVaH8GkrQ2+g@mail.gmail.com>
Subject: Re: [PATCH net-next v2] rds: rds_rm_zerocopy_callback() use list_first_entry()
To:     Pietro Borrello <borrello@diag.uniroma1.it>
Cc:     Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jkl820.git@gmail.com>,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
        sowmini.varadhan@oracle.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 7, 2023 at 9:57 AM Pietro Borrello
<borrello@diag.uniroma1.it> wrote:
>
> rds_rm_zerocopy_callback() uses list_entry() on the head of a list
> causing a type confusion.
> Use list_first_entry() to actually access the first element of the
> rs_zcookie_queue list.
>
> Fixes: 9426bbc6de99 ("rds: use list structure to track information for zerocopy completion notification")
> Signed-off-by: Pietro Borrello <borrello@diag.uniroma1.it>

This should go to net.

Reviewed-by: Willem de Bruijn <willemb@google.com>
