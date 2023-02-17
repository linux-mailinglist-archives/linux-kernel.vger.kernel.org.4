Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1E669A520
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 06:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjBQFgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 00:36:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBQFf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 00:35:58 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249D44DBC4;
        Thu, 16 Feb 2023 21:35:56 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id d8so4218060ljq.9;
        Thu, 16 Feb 2023 21:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rWva4xxS8q1iw/3ddXyeH06mIO4Txvijo6JEiv2lAxo=;
        b=aAesOw3ly4z1IlD112SNOICk1ygbNQoy+nDyB778JoLCHEb1igWrsTLKKVrJ3N4jGN
         g8OUU0e/j/W13m9yPH06nLKtTeddvA563MsXr93Fpa9hYYRvkWfvycactptJ+dlWp+Ao
         vi5bhii0oYV+nr+/8gfVVYHFw/rDU3SekpTpfLAjR59H2XPpjiNel2vbhMdwRjjhPFGd
         YawMnN8uWCKySzOo4N6kdVOvjYDsWMDiL12VH+YrgbOIzv2+nzqkZg48hAk895ZDiVIA
         jCh8yt1fvaVV/yEayOjX9U4aX6xiJZdAI91rnMGuV/haslldbz7LpsJnlpFTYGf+PGTP
         s53w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rWva4xxS8q1iw/3ddXyeH06mIO4Txvijo6JEiv2lAxo=;
        b=VmwqvPFESj5l4Ef4kzuFQZnBfFD7BQ79ogwyt2DOm40YKS2LhzrzrvLrKV7BUyFSua
         8ZVr5h4UN/I2Tk7m/trWOVxj0PB6fNUL5xmab0z9QY2/vpDJmqwK4k/kNQWUPa4ZGk0m
         DVsZoaK5lt3xtt97IzS868g9AYFwP1BEZnHW1xvvMFWc+NTTkfJjxd9sTgu1PYN5NnaD
         52tc0qfM9nl63s1PmLeVs72Xz7w4NONQ9AGEDxQfB4ETC+aD3ObHf5M5Ac/2LPe4eWFM
         T8+3vZLNwt7BijFQTQBjfyPAzF5Nny1ytlaRpX6xt5lmpczcKEI/Um2vUzezLdjWr0Mt
         vAjg==
X-Gm-Message-State: AO0yUKUNuIA5RvBy0/BhsFsJfsp72FRRYQN8c9yvKTx96boSQ9wRW6DL
        NcIrDQko8sp7+kOy3633GdShl5FJmeH2hA7C1Xo=
X-Google-Smtp-Source: AK7set9MEOglzLTI8rbidr0loBB8RX4UB4/hIsI4AUFlivFTBEybEd71GoMzu57L/GHd+tGuuPl0wk5hmT6+YQDg0g4=
X-Received: by 2002:a2e:8e3a:0:b0:293:5169:6cc6 with SMTP id
 r26-20020a2e8e3a000000b0029351696cc6mr74807ljk.7.1676612154091; Thu, 16 Feb
 2023 21:35:54 -0800 (PST)
MIME-Version: 1.0
References: <20230215000832.never.591-kees@kernel.org>
In-Reply-To: <20230215000832.never.591-kees@kernel.org>
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 16 Feb 2023 23:35:42 -0600
Message-ID: <CAH2r5mv5uKRJtq5buaDzmW5D61gv_E5P=xn5kxjbTwdBa33nsQ@mail.gmail.com>
Subject: Re: [PATCH] cifs: Convert struct fealist away from 1-element array
To:     Kees Cook <keescook@chromium.org>
Cc:     Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

merged into cifs-2.6.git for-next

On Tue, Feb 14, 2023 at 6:16 PM Kees Cook <keescook@chromium.org> wrote:
>
> The kernel is globally removing the ambiguous 0-length and 1-element
> arrays in favor of flexible arrays, so that we can gain both compile-time
> and run-time array bounds checking[1].
>
> While struct fealist is defined as a "fake" flexible array (via a
> 1-element array), it is only used for examination of the first array
> element. Walking the list is performed separately, so there is no reason
> to treat the "list" member of struct fealist as anything other than a
> single entry. Adjust the struct and code to match.
>
> Additionally, struct fea uses the "name" member either as a dynamic
> string, or is manually calculated from the start of the struct. Redefine
> the member as a flexible array.
>
> No machine code output differences are produced after these changes.
>
> [1] For lots of details, see both:
>     https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays
>     https://people.kernel.org/kees/bounded-flexible-arrays-in-c
>
> Cc: Steve French <sfrench@samba.org>
> Cc: Paulo Alcantara <pc@cjr.nz>
> Cc: Ronnie Sahlberg <lsahlber@redhat.com>
> Cc: Shyam Prasad N <sprasad@microsoft.com>
> Cc: Tom Talpey <tom@talpey.com>
> Cc: linux-cifs@vger.kernel.org
> Cc: samba-technical@lists.samba.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  fs/cifs/cifspdu.h |  4 ++--
>  fs/cifs/cifssmb.c | 16 ++++++++--------
>  2 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/fs/cifs/cifspdu.h b/fs/cifs/cifspdu.h
> index 623caece2b10..add73be4902c 100644
> --- a/fs/cifs/cifspdu.h
> +++ b/fs/cifs/cifspdu.h
> @@ -2583,7 +2583,7 @@ struct fea {
>         unsigned char EA_flags;
>         __u8 name_len;
>         __le16 value_len;
> -       char name[1];
> +       char name[];
>         /* optionally followed by value */
>  } __attribute__((packed));
>  /* flags for _FEA.fEA */
> @@ -2591,7 +2591,7 @@ struct fea {
>
>  struct fealist {
>         __le32 list_len;
> -       struct fea list[1];
> +       struct fea list;
>  } __attribute__((packed));
>
>  /* used to hold an arbitrary blob of data */
> diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
> index 60dd4e37030a..7c587157d030 100644
> --- a/fs/cifs/cifssmb.c
> +++ b/fs/cifs/cifssmb.c
> @@ -5787,7 +5787,7 @@ CIFSSMBQAllEAs(const unsigned int xid, struct cifs_tcon *tcon,
>
>         /* account for ea list len */
>         list_len -= 4;
> -       temp_fea = ea_response_data->list;
> +       temp_fea = &ea_response_data->list;
>         temp_ptr = (char *)temp_fea;
>         while (list_len > 0) {
>                 unsigned int name_len;
> @@ -5902,7 +5902,7 @@ CIFSSMBSetEA(const unsigned int xid, struct cifs_tcon *tcon,
>         else
>                 name_len = strnlen(ea_name, 255);
>
> -       count = sizeof(*parm_data) + ea_value_len + name_len;
> +       count = sizeof(*parm_data) + 1 + ea_value_len + name_len;
>         pSMB->MaxParameterCount = cpu_to_le16(2);
>         /* BB find max SMB PDU from sess */
>         pSMB->MaxDataCount = cpu_to_le16(1000);
> @@ -5926,14 +5926,14 @@ CIFSSMBSetEA(const unsigned int xid, struct cifs_tcon *tcon,
>         byte_count = 3 /* pad */  + params + count;
>         pSMB->DataCount = cpu_to_le16(count);
>         parm_data->list_len = cpu_to_le32(count);
> -       parm_data->list[0].EA_flags = 0;
> +       parm_data->list.EA_flags = 0;
>         /* we checked above that name len is less than 255 */
> -       parm_data->list[0].name_len = (__u8)name_len;
> +       parm_data->list.name_len = (__u8)name_len;
>         /* EA names are always ASCII */
>         if (ea_name)
> -               strncpy(parm_data->list[0].name, ea_name, name_len);
> -       parm_data->list[0].name[name_len] = 0;
> -       parm_data->list[0].value_len = cpu_to_le16(ea_value_len);
> +               strncpy(parm_data->list.name, ea_name, name_len);
> +       parm_data->list.name[name_len] = '\0';
> +       parm_data->list.value_len = cpu_to_le16(ea_value_len);
>         /* caller ensures that ea_value_len is less than 64K but
>         we need to ensure that it fits within the smb */
>
> @@ -5941,7 +5941,7 @@ CIFSSMBSetEA(const unsigned int xid, struct cifs_tcon *tcon,
>              negotiated SMB buffer size BB */
>         /* if (ea_value_len > buffer_size - 512 (enough for header)) */
>         if (ea_value_len)
> -               memcpy(parm_data->list[0].name+name_len+1,
> +               memcpy(parm_data->list.name + name_len + 1,
>                        ea_value, ea_value_len);
>
>         pSMB->TotalDataCount = pSMB->DataCount;
> --
> 2.34.1
>


-- 
Thanks,

Steve
